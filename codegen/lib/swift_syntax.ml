(* Swift as the generator writes it: a generated file's declarations, the
   types and values they hold, and the statements a table's own dispatch and
   a model's Codable conformance need, with a printer that writes them. A
   writer builds a file of these and never a line of Swift: a name is
   checked to be one, and a keyword among them is backticked where Swift
   needs it (anywhere but as an argument's label); a string is quoted and
   escaped by the printer; a number is grouped as swift-format groups it.

   The printer lays the file out as swift-format 6.4.2 does under
   swift/sdk/.swift-format, so the file is that formatter's fixed point. It
   turns the tree into the tokens swift-format's TokenStreamCreator makes of
   the same source, and Swift_layout prints them. Where the source a writer
   means has a line break, the tree says so: a block, a member list, a
   closure, an array or a dictionary is [Inline], written on the line it
   opens on with its statements apart only where it holds several, or
   [Lines], an entry to a line; and a declaration of a file is a line or a
   blank line after the one before it. *)

module L = Swift_layout

type layout = Inline | Lines

type type_ =
  | Named of string
  | Generic of string * type_ list  (** [Set<String>] *)
  | Optional of type_
  | Array_of of type_
  | Dictionary_of of type_ * type_
  | Metatype of type_  (** [Value.Type] *)
  | Any of type_  (** [any Decoder] *)
  | Inout of type_
  | Escaping of type_  (** A closure parameter's: [@escaping t]. *)
  | Function of {
      sendable : bool;
      params : type_ list;
      async_ : bool;
      throws : bool;
      result : type_;
    }
  | Tuple_of of type_ list
  | Composition of type_ list  (** [Codable & Sendable] *)

type expr =
  | Name of string  (** A value, a type or [self] by its name. *)
  | Member of expr * string
  | Implicit_member of string  (** [.name] *)
  | Call of expr * arg list
  | Subscript of expr * arg list
  | Type_value of type_  (** A type where an expression stands: [[T](...)]. *)
  | String of string
  | Int of int
  | Float of float
  | Bool of bool
  | Nil
  | Array of layout * expr list
  | Dictionary of layout * (expr * expr) list
  | Tuple of expr list  (** One element is a parenthesised expression. *)
  | Try of expr
  | Try_optional of expr
  | Not of expr
  | Binary of expr * string * expr
      (** The writer states the grouping: an operand that is itself an operation
          of lower precedence is one the writer nests. *)
  | Ternary of expr * expr * expr
  | Closure of { params : string list; layout : layout; body : stmt list }
  | Chained of expr  (** [e?] *)
  | Bind of string  (** [let x] in a case's pattern. *)
  | Discard  (** [_] *)

and arg = { label : string option; value : expr }

and stmt =
  | Expr of expr
  | Let of { var : bool; name : string; type_ : type_ option; value : expr }
  | Return of expr option
  | Throw of expr
  | If of if_
  | Guard of { conditions : condition list; else_ : block }
  | Switch of { subject : expr; layout : layout; cases : case list }
  | For of {
      names : string list;  (** One name, or a tuple's. *)
      sequence : expr;
      where_ : expr option;
      body : block;
    }
  | Do_catch of block * block
  | Break

and if_ = { conditions : condition list; body : block; else_ : else_ option }
and else_ = Else of block | Else_if of if_
and condition = Is of expr | Let_bound of string * expr

and case = {
  patterns : expr list;  (** Empty for [default]. *)
  body : stmt list;
}

and block = { layout : layout; stmts : stmt list }

type param = {
  label : string option;  (** [_], or an argument label beside the name. *)
  name : string;
  type_ : type_;
  default : expr option;
}

type generic = { name : string; conforms : type_ }
type case_value = Bare | Raw of expr | Associated of type_ list

type decl = { doc : string list; modifiers : string list; body : decl_body }

and decl_body =
  | Struct of {
      name : string;
      generics : generic list;
      inherits : type_ list;
      layout : layout;
      members : decl list;
    }
  | Enum of {
      name : string;
      inherits : type_ list;
      layout : layout;
      members : decl list;
    }
  | Extension of { name : string; layout : layout; members : decl list }
  | Typealias of { name : string; type_ : type_ }
  | Property of {
      var : bool;
      name : string;
      type_ : type_ option;
      value : expr option;
    }
  | Computed of { name : string; type_ : type_; body : block }
  | Init of { params : param list; throws : bool; body : block }
  | Func of {
      name : string;
      generics : generic list;
      params : param list;
      throws : bool;
      result : type_ option;
      body : block;
    }
  | Case of { name : string; value : case_value }

type gap = Line | Blank
type import = { module_ : string; testable : bool }

type file = {
  banner : string list;  (** Comment lines, without their [//]. *)
  imports : import list;
  decls : (gap * decl) list;
}

(* Names *)

let keywords =
  [
    "associatedtype";
    "class";
    "deinit";
    "enum";
    "extension";
    "fileprivate";
    "func";
    "import";
    "init";
    "inout";
    "internal";
    "let";
    "open";
    "operator";
    "private";
    "precedencegroup";
    "protocol";
    "public";
    "rethrows";
    "static";
    "struct";
    "subscript";
    "typealias";
    "var";
    "break";
    "case";
    "catch";
    "continue";
    "default";
    "defer";
    "do";
    "else";
    "fallthrough";
    "for";
    "guard";
    "if";
    "in";
    "repeat";
    "return";
    "throw";
    "switch";
    "where";
    "while";
    "Any";
    "as";
    "await";
    "false";
    "is";
    "nil";
    "super";
    "throws";
    "true";
    "try";
    "_";
    "Type";
    "Protocol";
  ]

let is_name name =
  name <> ""
  && String.for_all
       (function
         | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
       name
  && not (match name.[0] with '0' .. '9' -> true | _ -> false)

(* A name as Swift spells it where it names: backticked if a keyword. [self]
   and [Self] name themselves, and [$0] is a closure's first argument. *)
let name text =
  if text = "self" || text = "Self" || text = "$0" then text
  else if not (is_name text) then
    invalid_arg (Printf.sprintf "Swift_syntax: %S is no Swift name" text)
  else if List.mem text keywords then "`" ^ text ^ "`"
  else text

(* A member's name after a period, where [init] names the initializer. *)
let member_name text = if text = "init" then text else name text

let label text =
  if is_name text then text
  else invalid_arg (Printf.sprintf "Swift_syntax: %S is no argument label" text)

let operators = [ "=="; ">="; "<="; "&&"; "||"; "..."; "=" ]

(* A string's characters as a Swift literal holds them: a quote and a
   backslash escaped, and a control character by its code point. *)
let escaped text =
  let out = Buffer.create (String.length text) in
  Text.fold_uchars
    (fun () u ->
      match Uchar.to_int u with
      | 34 -> Buffer.add_string out "\\\""
      | 92 -> Buffer.add_string out "\\\\"
      | c when c <= 31 || (c >= 127 && c <= 159) ->
          Buffer.add_string out (Printf.sprintf "\\u{%x}" c)
      | _ -> Buffer.add_utf_8_uchar out u)
    () text;
  Buffer.contents out

(* A whole number as GroupNumericLiterals writes it: seven digits or more in
   threes. *)
let digits n =
  let text = string_of_int (abs n) in
  let length = String.length text in
  if length < 7 then text
  else
    let rec groups acc i =
      if i <= 0 then acc
      else
        let start = max 0 (i - 3) in
        groups (String.sub text start (i - start) :: acc) start
    in
    String.concat "_" (groups [] length)

(* A number as Swift's description of a Double spells it: the shortest text
   that reads back as it, with a fraction. *)
let float_text f =
  if Float.is_integer f && Float.abs f < 1e16 then Printf.sprintf "%.0f.0" f
  else
    let rec shortest p =
      let text = Printf.sprintf "%.*g" p f in
      if p >= 17 || float_of_string text = f then text else shortest (p + 1)
    in
    shortest 1

(* Tokens: what the source holds, and what swift-format puts before and
   after each. An insertion is keyed by the visit that makes it, in the order
   swift-format's visitor reaches its node, and its place among that visit's
   own: the tokens before a token are in that order, the groups after it in
   the reverse. *)

type tok = {
  index : int;
  text : string;
  try_ : bool;  (** [try], or its [?]. *)
  mutable newlines : int;  (** The line breaks the source has before it. *)
  mutable comment : (L.comment_kind * string list) option;
  mutable befores : ((int * int) * L.token list) list;
  mutable afters : ((int * int) * L.token list) list;
  mutable closing_delimiter : int option;
      (** Where it closes a node whose contents end at the token before it (a
          condition's comma, a one-element tuple's [)]): that node's visit. The
          afters of the token before it from later visits follow it instead. *)
}

type builder = {
  mutable toks : tok list;
  mutable count : int;
  mutable order : int;
  mutable seq : int;
}

let tok ?(try_ = false) b text =
  let t =
    {
      index = b.count;
      text;
      try_;
      newlines = 0;
      comment = None;
      befores = [];
      afters = [];
      closing_delimiter = None;
    }
  in
  b.toks <- t :: b.toks;
  b.count <- b.count + 1;
  t

let visit b =
  b.order <- b.order + 1;
  b.order

let key b order =
  b.seq <- b.seq + 1;
  (order, b.seq)

let before b order t tokens = t.befores <- (key b order, tokens) :: t.befores
let after b order t tokens = t.afters <- (key b order, tokens) :: t.afters

let break_ ?(size = 1) ?(newline = L.Elective { ignores_discretionary = false })
    kind =
  L.Break { kind; size; newline }

let ignoring = L.Elective { ignores_discretionary = true }
let continue_ = break_ L.Continue
let same = break_ L.Same
let open_block = break_ (L.Open_break L.Block)
let open_block0 = break_ ~size:0 (L.Open_break L.Block)
let open_continuation = break_ (L.Open_break L.Continuation)
let open_continuation0 = break_ ~size:0 (L.Open_break L.Continuation)
let close_must size = break_ ~size (L.Close_break { must = true })
let close_free = break_ ~size:0 (L.Close_break { must = false })
let space = L.Space 1
let group = L.Open L.Inconsistent
let consistent = L.Open L.Consistent

(* What a lowered node is, as far as a visit reads it. *)
type node = { first : tok; last : tok; shape : shape }

and shape =
  | Reference
  | Member_access of { base : node option; period : tok; name : tok }
  | Calling of { callee : node; subscript : bool }
  | Conditional of { condition : node }
  | Operation
  | Trying of node
  | Parenthesised of node
  | Closure_literal
  | Collection
  | Item of int  (** A case's pattern, by the order of its visit. *)
  | Other

let span first last shape = { first; last; shape }

(* Where an expression stands, for the visits that read its parent. *)
type place = Top | Callee | Base | Argument

let rec compound n =
  match n.shape with
  | Operation | Conditional _ -> true
  | Trying inner | Parenthesised inner -> compound inner
  | _ -> false

let starts_with_delimiter n =
  match n.first.text with "{" | "(" | "[" -> true | _ -> false

let rec anchor n =
  match n.shape with
  | Calling { callee; _ } -> anchor callee
  | Member_access { base = Some base; name; _ } ->
      if base.shape = Reference then Some name else anchor base
  | Reference -> Some n.last
  | _ -> None

(* The contextual breaks of a chain of member accesses and calls, from its
   outermost one: swift-format's insertContextualBreaks, where
   lineBreakAroundMultilineExpressionChainComponents is false. *)
let rec contextual b o n ~top ~callee =
  let context () =
    before b o n.first [ L.Context_start ];
    after b o n.last [ L.Context_end ]
  in
  match n.shape with
  | Member_access { base; period; _ } ->
      if base <> None && not callee then
        before b o period [ break_ ~size:0 L.Contextual ];
      let compound_base =
        match base with
        | Some base -> fst (contextual b o base ~top:false ~callee:false)
        | None -> false
      in
      if top then context ();
      (compound_base, true)
  | Calling { callee = called; _ } ->
      let _, member = contextual b o called ~top:false ~callee:true in
      (match called.shape with
      | Member_access { base; period; _ } ->
          if base <> None then before b o period [ break_ ~size:0 L.Contextual ];
          before b o period [ L.Context_start ];
          after b o n.last [ L.Context_end ];
          if top then context ()
      | _ -> context ());
      (true, member)
  | _ ->
      context ();
      (n.shape <> Reference, false)

let string_literal b text =
  let open_ = tok b "\"" in
  ignore (tok b (escaped text));
  let close = tok b "\"" in
  span open_ close Other

(* A comma-delimited list, as swift-format arranges one at the order [o]:
   the breaks between its entries, a group around each where [grouped], and
   its region, whose end follows the last entry's own last token. *)
let delimited b o ~grouped ~collection entries =
  match entries with
  | [] -> ()
  | first :: _ ->
      let count = List.length entries in
      List.iteri
        (fun i (entry, _) ->
          if i < count - 1 then after b o entry.last [ same ])
        entries;
      if grouped then
        List.iter
          (fun (entry, _) ->
            before b o entry.first [ group ];
            after b o entry.last [ L.Close ])
          entries;
      before b o (fst first).first [ L.Comma_start ];
      let _, last_expr = List.nth entries (count - 1) in
      after b o last_expr [ L.Comma_end { collection; single = count = 1 } ]

(* The entries of a list, each followed by a comma but the last; [lower]
   lowers one and returns it with its own last token. *)
let entries b lower items =
  let count = List.length items in
  List.mapi
    (fun i item ->
      let n, own_last = lower item in
      if i < count - 1 then
        let comma = tok b "," in
        ({ n with last = comma }, own_last)
      else (n, own_last))
    items

let rec type_ b t =
  match t with
  | Named n ->
      let t = tok b (name n) in
      span t t Reference
  | Generic (n, args) ->
      let head = tok b (name n) in
      let clause = generic_arguments b args in
      span head clause Other
  | Optional t ->
      let inner = type_ b t in
      span inner.first (tok b "?") Other
  | Array_of t ->
      let open_ = tok b "[" in
      ignore (type_ b t);
      span open_ (tok b "]") Other
  | Dictionary_of (k, v) ->
      let open_ = tok b "[" in
      ignore (type_ b k);
      let colon = tok b ":" in
      after b (visit b) colon [ continue_ ];
      ignore (type_ b v);
      span open_ (tok b "]") Other
  | Metatype t ->
      let inner = type_ b t in
      ignore (tok b ".");
      span inner.first (tok b "Type") Other
  | Any t ->
      let o = visit b in
      let any = tok b "any" in
      after b o any [ space ];
      let inner = type_ b t in
      span any inner.last Other
  | Inout t ->
      let o = visit b in
      let inout = tok b "inout" in
      after b o inout [ break_ ~newline:ignoring L.Continue ];
      let inner = type_ b t in
      before b o inout [ group ];
      after b o inner.last [ L.Close ];
      span inout inner.last Other
  | Escaping t ->
      let o = visit b in
      let at = tok b "@" in
      let escaping = tok b "escaping" in
      after b o escaping [ break_ ~newline:ignoring L.Continue ];
      let inner = type_ b t in
      before b o at [ group ];
      after b o inner.last [ L.Close ];
      span at inner.last Other
  | Function { sendable; params; async_; throws; result } ->
      let o = visit b in
      let attribute =
        if sendable then (
          let oa = visit b in
          let at = tok b "@" in
          let word = tok b "Sendable" in
          before b oa at [ group ];
          after b oa word [ L.Close ];
          after b o word [ break_ ~newline:ignoring L.Continue ];
          Some at)
        else None
      in
      let of_ = visit b in
      let open_ = tok b "(" in
      let ps =
        entries b
          (fun p ->
            let n = type_ b p in
            (n, n.last))
          params
      in
      let close = tok b ")" in
      after b of_ open_ [ open_block0; group ];
      before b of_ close [ close_must 0; L.Close ];
      List.iter
        (fun (p, _) ->
          before b of_ p.first [ group ];
          after b of_ p.last [ L.Close ])
        ps;
      if async_ then before b of_ (tok b "async") [ continue_ ];
      if throws then before b of_ (tok b "throws") [ continue_ ];
      let arrow = tok b "->" in
      before b of_ arrow [ continue_ ];
      after b of_ arrow [ continue_ ];
      let r = type_ b result in
      let first = Option.value attribute ~default:open_ in
      if sendable then (
        before b o first [ group ];
        after b o r.last [ L.Close ]);
      span first r.last Other
  | Tuple_of elements ->
      let o = visit b in
      let open_ = tok b "(" in
      let es =
        entries b
          (fun e ->
            let n = type_ b e in
            (n, n.last))
          elements
      in
      let close = tok b ")" in
      after b o open_ [ open_block0; group ];
      before b o close [ close_must 0; L.Close ];
      let count = List.length es in
      List.iteri
        (fun i (e, _) -> if i < count - 1 then after b o e.last [ same ])
        es;
      List.iter
        (fun (e, _) ->
          before b o e.first [ group ];
          after b o e.last [ L.Close ])
        es;
      span open_ close Other
  | Composition parts ->
      let o = visit b in
      let ns =
        List.mapi
          (fun i part ->
            if i > 0 then (
              let amp = tok b "&" in
              before b o amp [ continue_ ];
              after b o amp [ space ]);
            type_ b part)
          parts
      in
      span (List.hd ns).first (List.nth ns (List.length ns - 1)).last Other

and generic_arguments b args =
  let o = visit b in
  let open_ = tok b "<" in
  let ns =
    entries b
      (fun a ->
        let n = type_ b a in
        (n, n.last))
      args
  in
  let close = tok b ">" in
  after b o open_ [ open_block0; group ];
  before b o close [ close_must 0; L.Close ];
  let count = List.length ns in
  List.iteri
    (fun i (n, _) -> if i < count - 1 then after b o n.last [ same ])
    ns;
  List.iter
    (fun (n, _) ->
      let oa = visit b in
      before b oa n.first [ group ];
      after b oa n.last [ L.Close ])
    ns;
  close

let rec expr b ~place e =
  let chained = place = Callee || place = Base in
  match e with
  | Name n ->
      let t = tok b (name n) in
      span t t Reference
  | Discard ->
      let t = tok b "_" in
      span t t Other
  | Member (base, member) ->
      let o = visit b in
      let base = expr b ~place:Base base in
      let period = tok b "." in
      let member = tok b (member_name member) in
      let n =
        span base.first member
          (Member_access { base = Some base; period; name = member })
      in
      if not chained then ignore (contextual b o n ~top:true ~callee:false);
      n
  | Implicit_member member ->
      let o = visit b in
      let period = tok b "." in
      let member = tok b (member_name member) in
      let n =
        span period member
          (Member_access { base = None; period; name = member })
      in
      if not chained then ignore (contextual b o n ~top:true ~callee:false);
      n
  | Call (callee, args) -> calling b ~place ~subscript:false callee args
  | Subscript (callee, args) -> calling b ~place ~subscript:true callee args
  | Type_value t -> type_value b ~place t
  | String text -> string_literal b text
  | Int n ->
      if n < 0 then
        let minus = tok b "-" in
        span minus (tok b (digits n)) Other
      else
        let t = tok b (digits n) in
        span t t Other
  | Float f ->
      if f < 0. then
        let minus = tok b "-" in
        span minus (tok b (float_text (Float.neg f))) Other
      else
        let t = tok b (float_text f) in
        span t t Other
  | Bool truth ->
      let t = tok b (if truth then "true" else "false") in
      span t t Other
  | Nil ->
      let t = tok b "nil" in
      span t t Other
  | Array (layout, elements) ->
      collection b layout elements (fun e ->
          let n = expr b ~place:Argument e in
          (n, n.last))
  | Dictionary (layout, []) ->
      ignore layout;
      let open_ = tok b "[" in
      ignore (tok b ":");
      span open_ (tok b "]") Collection
  | Dictionary (layout, pairs) ->
      collection b layout pairs (fun (k, v) ->
          let o = visit b in
          let key = expr b ~place:Argument k in
          let colon = tok b ":" in
          after b o colon [ continue_ ];
          let value = expr b ~place:Argument v in
          (span key.first value.last Other, value.last))
  | Tuple [ element ] ->
      let o = visit b in
      let open_ = tok b "(" in
      let ol = visit b in
      let inner = expr b ~place:Argument element in
      let close = tok b ")" in
      close.closing_delimiter <- Some ol;
      before b o inner.first [ group ];
      after b o inner.last [ L.Close ];
      delimited b ol ~grouped:false ~collection:false [ (inner, inner.last) ];
      span open_ close (Parenthesised inner)
  | Tuple elements ->
      let o = visit b in
      let open_ = tok b "(" in
      let ol = visit b in
      let es =
        entries b
          (fun e ->
            let n = expr b ~place:Argument e in
            (n, n.last))
          elements
      in
      let close = tok b ")" in
      after b o open_ [ open_block0; group ];
      before b o close [ close_must 0; L.Close ];
      delimited b ol ~grouped:true ~collection:false es;
      span open_ close Other
  | Try inner ->
      let o = visit b in
      let t = tok ~try_:true b "try" in
      trying b o t t inner
  | Try_optional inner ->
      let o = visit b in
      let t = tok ~try_:true b "try" in
      let question = tok ~try_:true b "?" in
      trying b o t question inner
  | Not inner ->
      let bang = tok b "!" in
      let n = expr b ~place:Argument inner in
      span bang n.last Other
  | Binary (left, op, right) -> binary b left op right
  | Ternary (condition, yes, no) ->
      let o = visit b in
      let c = expr b ~place:Argument condition in
      let question = tok b "?" in
      ignore (expr b ~place:Argument yes);
      let colon = tok b ":" in
      let n = expr b ~place:Argument no in
      before b o question [ open_continuation; group ];
      after b o question [ space ];
      before b o colon [ close_free; open_continuation; group ];
      after b o colon [ space ];
      after b o n.last [ close_free; L.Close; L.Close ];
      span c.first n.last (Conditional { condition = c })
  | Closure { params; layout; body } -> closure b params layout body
  | Chained inner ->
      let n = expr b ~place:Argument inner in
      span n.first (tok b "?") Other
  | Bind bound ->
      let o = visit b in
      let let_ = tok b "let" in
      after b o let_ [ continue_ ];
      span let_ (tok b (name bound)) Other

and type_value b ~place t =
  match t with
  | Named n -> expr b ~place (Name n)
  | Generic (n, args) ->
      let head = tok b (name n) in
      span head (generic_arguments b args) Other
  | Array_of t ->
      collection b Inline [ t ] (fun t ->
          let n = type_value b ~place:Argument t in
          (n, n.last))
  | Dictionary_of (k, v) ->
      collection b Inline
        [ (k, v) ]
        (fun (k, v) ->
          let o = visit b in
          let key = type_value b ~place:Argument k in
          let colon = tok b ":" in
          after b o colon [ continue_ ];
          let value = type_value b ~place:Argument v in
          (span key.first value.last Other, value.last))
  | _ ->
      invalid_arg "Swift_syntax: a type no expression in Swift's grammar spells"

and collection : 'a. builder -> layout -> 'a list -> ('a -> node * tok) -> node
    =
 fun b layout items lower ->
  let o = visit b in
  let open_ = tok b "[" in
  let ol = visit b in
  let es = entries b lower items in
  let close = tok b "]" in
  if es <> [] then (
    after b o open_ [ open_block0; group ];
    before b o close [ close_must 0; L.Close ]);
  delimited b ol ~grouped:true ~collection:true es;
  if layout = Lines then (
    List.iter (fun (e, _) -> e.first.newlines <- 1) es;
    close.newlines <- 1);
  span open_ close Collection

and trying b o t last_keyword inner =
  let n = expr b ~place:Argument inner in
  (match anchor n with
  | Some a ->
      before b o t [ group ];
      after b o a [ L.Close ]
  | None -> ());
  before b o n.first [ break_ ~newline:ignoring L.Continue ];
  ignore last_keyword;
  span t n.last (Trying n)

and calling b ~place ~subscript callee args =
  let o = visit b in
  let c = expr b ~place:Callee callee in
  let open_ = tok b (if subscript then "[" else "(") in
  let ol = visit b in
  let lowered =
    entries b
      (fun { label = l; value } ->
        let oa = visit b in
        let label_tok =
          Option.map
            (fun l ->
              let t = tok b (label l) in
              (t, tok b ":"))
            l
        in
        let v = expr b ~place:Argument value in
        Option.iter
          (fun (_, colon) ->
            after b oa colon
              [ (if starts_with_delimiter v then space else continue_) ])
          label_tok;
        let first = match label_tok with Some (t, _) -> t | None -> v.first in
        (span first v.last v.shape, v.last))
      args
  in
  let close = tok b (if subscript then "]" else ")") in
  let n = span c.first close (Calling { callee = c; subscript }) in
  let chained = place = Callee || place = Base in
  if not chained then ignore (contextual b o n ~top:true ~callee:false);
  (match c.shape with
  | Member_access { base = Some base; name; _ }
    when base.shape = Reference && not (preceded_by_try b base.first) ->
      before b o base.first [ group ];
      after b o name [ L.Close ]
  | _ -> ());
  let compact =
    match (args, lowered) with
    | [ _ ], [ (v, _) ] -> (
        match v.shape with Closure_literal | Collection -> true | _ -> false)
    | _ -> false
  in
  (match lowered with
  | [] -> ()
  | _ when compact ->
      after b o open_ [ open_block0 ];
      before b o close [ close_free ]
  | _ ->
      after b o open_ [ open_block0; group ];
      let must = place = Base in
      before b o close [ break_ ~size:0 (L.Close_break { must }); L.Close ]);
  delimited b ol ~grouped:(not compact) ~collection:false lowered;
  n

and preceded_by_try b t =
  t.index > 0 && (List.nth b.toks (b.count - t.index)).try_

and binary b left op right =
  let o = visit b in
  let l = expr b ~place:Argument left in
  if not (List.mem op operators) then
    invalid_arg (Printf.sprintf "Swift_syntax: %S is no operator it writes" op);
  let operator = tok b op in
  let r = expr b ~place:Argument right in
  (match r.shape with
  | Member_access _ | Calling { subscript = true; _ } ->
      before b o r.first [ group ];
      after b o r.last [ L.Close ]
  | Calling { subscript = false; _ } when op <> "=" ->
      before b o r.first [ group ];
      after b o r.last [ L.Close ]
  | _ -> ());
  (match op with
  | "=" ->
      before b o operator [ space ];
      let breaks =
        match r.shape with
        | Conditional { condition } ->
            after b o condition.last [ close_free; L.Close ];
            [ open_continuation; group ]
        | _ -> [ continue_ ]
      in
      let breaks =
        if compound r then (
          after b o r.last [ L.Close ];
          breaks @ [ group ])
        else breaks
      in
      after b o operator breaks
  | "..." -> ()
  | "&&" | "||" ->
      before b o operator [ open_continuation; group ];
      after b o operator [ space ];
      after b o r.last [ break_ ~size:0 L.Reset; close_free; L.Close ]
  | _ ->
      before b o operator [ continue_ ];
      after b o operator [ space ]);
  span l.first r.last Operation

and closure b params layout body =
  let o = visit b in
  let open_ = tok b "{" in
  let signature =
    match params with
    | [] -> None
    | _ ->
        let os = visit b in
        let ps =
          List.mapi
            (fun i p ->
              let op = visit b in
              if i > 0 then ignore (tok b ",");
              let t = tok b (name p) in
              before b op t [ group ];
              after b op t [ L.Close ];
              t)
            params
        in
        let in_ = tok b "in" in
        before b os (List.hd ps) [ group ];
        before b os in_ [ same ];
        after b os in_ [ L.Close ];
        Some in_
  in
  let items = statements b layout body in
  let close = tok b "}" in
  if layout = Lines then close.newlines <- 1;
  let newline =
    if List.length body > 1 then L.Soft { count = 1; discretionary = false }
    else L.Elective { ignores_discretionary = false }
  in
  (match signature with
  | Some in_ ->
      after b o open_ [ open_block ];
      after b o in_ [ break_ ~size:(if items then 1 else 0) ~newline L.Same ];
      before b o close [ close_must 1 ]
  | None -> braces b o ~reset:false ~newline ~empty:(not items) open_ close);
  span open_ close Closure_literal

(* swift-format's arrangeBracesAndContents. *)
and braces b o ~reset ~newline ~empty open_ close =
  if reset then before b o open_ [ break_ ~newline:ignoring L.Reset ];
  if empty then (
    after b o open_ [ break_ ~size:0 ~newline (L.Open_break L.Block) ];
    before b o close [ close_must 0 ])
  else (
    after b o open_ [ break_ ~newline (L.Open_break L.Block); group ];
    before b o close [ close_must 1; L.Close ])

(* A list of items, each a group with a reset after it; [true] if it holds
   any. *)
and items : 'a. builder -> layout -> 'a list -> ('a -> node) -> bool =
 fun b layout entries lower ->
  let o = visit b in
  List.iteri
    (fun i entry ->
      let oi = visit b in
      let n = lower entry in
      before b oi n.first [ group ];
      after b oi n.last [ L.Close ];
      after b o n.last [ break_ ~size:0 L.Reset ];
      if layout = Lines || i > 0 then n.first.newlines <- 1)
    entries;
  entries <> []

and statements b layout stmts = items b layout stmts (statement b)

and code_block b o ~reset { layout; stmts } =
  let open_ = tok b "{" in
  let held = statements b layout stmts in
  let close = tok b "}" in
  if layout = Lines then close.newlines <- 1;
  braces b o ~reset
    ~newline:(L.Elective { ignores_discretionary = false })
    ~empty:(not held) open_ close;
  close

and statement b s =
  match s with
  | Expr e -> expr b ~place:Top e
  | Let { var; name = n; type_ = t; value } ->
      let o = visit b in
      let keyword = tok b (if var then "var" else "let") in
      after b o keyword [ space ];
      let last = binding b ~name:n ~type_:t ~value:(Some value) in
      span keyword last Other
  | Return value ->
      let o = visit b in
      let keyword = tok b "return" in
      let last =
        match value with
        | None -> keyword
        | Some v ->
            after b o keyword [ continue_ ];
            (expr b ~place:Top v).last
      in
      span keyword last Other
  | Throw value ->
      let o = visit b in
      let keyword = tok b "throw" in
      after b o keyword [ continue_ ];
      span keyword (expr b ~place:Top value).last Other
  | Break ->
      let t = tok b "break" in
      span t t Other
  | If if_ -> if_statement b ~top:true if_
  | Guard { conditions; else_ } ->
      let o = visit b in
      let keyword = tok b "guard" in
      after b o keyword [ space ];
      let cs = conditions_ b conditions in
      List.iter
        (fun (c : node) ->
          before b o c.first [ open_continuation0 ];
          after b o c.last [ close_free ])
        cs;
      let else_tok = tok b "else" in
      before b o else_tok [ break_ L.Reset; group ];
      after b o else_tok [ space ];
      let open_ = tok b "{" in
      before b o open_ [ L.Close ];
      let held = statements b else_.layout else_.stmts in
      let close = tok b "}" in
      if else_.layout = Lines then close.newlines <- 1;
      braces b o ~reset:false
        ~newline:(L.Elective { ignores_discretionary = false })
        ~empty:(not held) open_ close;
      span keyword close Other
  | Switch { subject; layout; cases } ->
      let o = visit b in
      let keyword = tok b "switch" in
      before b o keyword [ group ];
      after b o keyword [ space ];
      ignore (expr b ~place:Top subject);
      let open_ = tok b "{" in
      before b o open_ [ break_ L.Reset ];
      after b o open_ [ L.Close ];
      let ol = visit b in
      List.iter
        (fun { patterns; body } ->
          let oc = visit b in
          let first, label_last =
            match patterns with
            | [] ->
                let d = tok b "default" in
                (d, tok b ":")
            | _ ->
                let ocl = visit b in
                let keyword = tok b "case" in
                after b ocl keyword [ space ];
                let ps =
                  entries b
                    (fun p ->
                      let oi = visit b in
                      let n = expr b ~place:Top p in
                      ({ n with shape = Item oi }, n.last))
                    patterns
                in
                let count = List.length ps in
                List.iteri
                  (fun i ((p : node), _) ->
                    (match p.shape with
                    | Item oi ->
                        before b oi p.first [ group ];
                        after b oi p.last [ L.Close ]
                    | _ -> ());
                    if i < count - 1 then after b ocl p.last [ continue_ ])
                  ps;
                let colon = tok b ":" in
                before b ocl keyword [ group ];
                after b ocl colon [ L.Close ];
                (keyword, colon)
          in
          before b oc first
            [
              break_
                ~newline:(L.Soft { count = 1; discretionary = false })
                L.Same;
            ];
          if layout = Lines then first.newlines <- 1;
          after b oc label_last [ break_ ~size:0 L.Reset; open_block; group ];
          ignore (statements b Inline body);
          let last = List.hd b.toks in
          after b oc last [ close_must 0; L.Close ])
        cases;
      ignore ol;
      let close = tok b "}" in
      if layout = Lines then close.newlines <- 1;
      before b o close
        [
          break_ ~size:0
            ~newline:(L.Soft { count = 1; discretionary = false })
            L.Same;
        ];
      span keyword close Other
  | For { names; sequence; where_; body } ->
      let o = visit b in
      let keyword = tok b "for" in
      after b o keyword [ space ];
      (match names with
      | [ n ] -> ignore (tok b (name n))
      | _ ->
          let op = visit b in
          let open_ = tok b "(" in
          let ns =
            entries b
              (fun n ->
                let t = tok b (name n) in
                (span t t Reference, t))
              names
          in
          let close = tok b ")" in
          after b op open_ [ open_block0; group ];
          before b op close [ close_must 0; L.Close ];
          delimited b op ~grouped:false ~collection:false ns);
      let in_ = tok b "in" in
      before b o in_ [ continue_ ];
      after b o in_ [ space ];
      ignore (expr b ~place:Top sequence);
      Option.iter
        (fun w ->
          let ow = visit b in
          let keyword = tok b "where" in
          before b ow keyword [ same; group ];
          after b ow keyword [ continue_ ];
          let n = expr b ~place:Top w in
          after b ow n.last [ L.Close ])
        where_;
      span keyword (code_block b o ~reset:true body) Other
  | Do_catch (body, handler) ->
      let o = visit b in
      let keyword = tok b "do" in
      ignore (code_block b o ~reset:true body);
      let oc = visit b in
      let catch = tok b "catch" in
      before b oc catch [ space ];
      span keyword (code_block b oc ~reset:true handler) Other

and if_statement b ~top { conditions; body; else_ } =
  let o = visit b in
  let keyword = tok b "if" in
  after b o keyword [ space ];
  let cs = conditions_ b conditions in
  let first = (List.hd cs).first
  and last = (List.nth cs (List.length cs - 1)).last in
  before b o first [ group ];
  after b o last [ L.Close ];
  List.iteri
    (fun i (c : node) ->
      if i > 0 then (
        before b o c.first [ open_continuation0 ];
        after b o c.last [ close_free ]))
    cs;
  let close = code_block b o ~reset:true body in
  let close =
    match else_ with
    | None -> close
    | Some else_ -> (
        let else_tok = tok b "else" in
        before b o else_tok [ space ];
        match else_ with
        | Else_if nested ->
            after b o else_tok [ space ];
            (if_statement b ~top:false nested).last
        | Else block -> code_block b o ~reset:true block)
  in
  let n = span keyword close Other in
  if top then (
    (* swift-format's CodeBlockItem visit, before this one. *)
    let oi = o - 1 in
    before b oi first [ consistent ];
    after b oi close [ L.Close ]);
  n

and conditions_ b conditions =
  let count = List.length conditions in
  List.mapi
    (fun i c ->
      let o = visit b in
      let n =
        match c with
        | Is e -> expr b ~place:Top e
        | Let_bound (bound, value) ->
            let ob = visit b in
            let let_ = tok b "let" in
            after b ob let_ [ continue_ ];
            ignore (tok b (name bound));
            let equal = tok b "=" in
            before b (visit b) equal [ space ];
            let v = expr b ~place:Top value in
            (match v.shape with
            | Conditional { condition } ->
                after b ob equal [ open_continuation; group ];
                after b ob condition.last [ close_free; L.Close ]
            | _ -> after b ob equal [ continue_ ]);
            if compound v then (
              before b ob v.first [ group ];
              after b ob v.last [ L.Close ]);
            span let_ v.last Other
      in
      before b o n.first [ group ];
      if i < count - 1 then (
        let comma = tok b "," in
        comma.closing_delimiter <- Some o;
        after b o comma [ L.Close; same ];
        { n with last = comma })
      else (
        after b o n.last [ L.Close ];
        n))
    conditions

(* A binding's type and value, after its name: swift-format's
   PatternBinding visit. *)
and binding b ~name:n ~type_:t ~value =
  let o = visit b in
  let name_tok = tok b (name n) in
  let annotated =
    Option.map
      (fun t ->
        let colon = tok b ":" in
        after b o colon
          [ break_ ~newline:ignoring (L.Open_break L.Continuation) ];
        let ot = visit b in
        let n = type_ b t in
        before b ot n.first [ group ];
        after b ot n.last [ L.Close ];
        n.last)
      t
  in
  let last =
    match value with
    | None -> Option.value annotated ~default:name_tok
    | Some v ->
        let equal = tok b "=" in
        before b (visit b) equal [ space ];
        let n = expr b ~place:Top v in
        (match n.shape with
        | Conditional { condition } ->
            after b o equal [ open_continuation; group ];
            after b o condition.last [ close_free; L.Close ]
        | _ -> after b o equal [ continue_ ]);
        if compound n then (
          before b o n.first [ group ];
          after b o n.last [ L.Close ]);
        n.last
  in
  if annotated <> None then after b o last [ close_must 0 ];
  last

let modifiers b o list =
  List.map
    (fun m ->
      let t = tok b m in
      after b o t [ continue_ ];
      t)
    list

let doc_comment (first : tok) = function
  | [] -> ()
  | lines ->
      first.comment <-
        Some
          ( L.Doc_line,
            List.map (fun l -> if l = "" then "///" else "/// " ^ l) lines )

let generic_parameters b generics =
  match generics with
  | [] -> None
  | _ ->
      let o = visit b in
      let open_ = tok b "<" in
      let ol = visit b in
      let ps =
        entries b
          (fun { name = n; conforms } ->
            let op = visit b in
            let t = tok b (name n) in
            let colon = tok b ":" in
            after b op colon [ continue_ ];
            let c = type_ b conforms in
            (span t c.last Other, c.last))
          generics
      in
      let close = tok b ">" in
      after b o open_ [ open_block0; group ];
      before b o close [ close_must 0; L.Close ];
      delimited b ol ~grouped:false ~collection:false ps;
      List.iter
        (fun ((p : node), _) ->
          let op = visit b in
          before b op p.first [ group ];
          after b op p.last [ L.Close ])
        ps;
      Some close

let parameters b o ~body params =
  let open_ = tok b "(" in
  let ol = visit b in
  let ps =
    entries b
      (fun { label = l; name = n; type_ = t; default } ->
        let op = visit b in
        let first =
          match l with
          | Some l ->
              let t = tok b (label l) in
              after b op t [ break_ ~newline:ignoring L.Continue ];
              Some t
          | None -> None
        in
        let name_tok = tok b (name n) in
        let colon = tok b ":" in
        after b op colon [ continue_ ];
        let ty = type_ b t in
        let last =
          match default with
          | None -> ty.last
          | Some d ->
              let equal = tok b "=" in
              before b (visit b) equal [ space ];
              after b op equal [ continue_ ];
              (expr b ~place:Top d).last
        in
        (span (Option.value first ~default:name_tok) last Other, last))
      params
  in
  let close = tok b ")" in
  if ps <> [] then (
    after b o open_ [ open_block0; group ];
    before b o close [ break_ ~size:0 (L.Close_break { must = body }); L.Close ]);
  delimited b ol ~grouped:false ~collection:false ps;
  List.iter
    (fun ((p : node), _) ->
      let op = visit b in
      before b op p.first [ group ];
      after b op p.last [ L.Close ])
    ps;
  (open_, close, ps <> [])

let rec decl b { doc; modifiers = mods; body } =
  match body with
  | Struct { name = n; generics; inherits; layout; members } ->
      type_decl b ~doc ~mods ~keyword:"struct" ~name:n ~generics ~inherits
        ~layout members
  | Enum { name = n; inherits; layout; members } ->
      type_decl b ~doc ~mods ~keyword:"enum" ~name:n ~generics:[] ~inherits
        ~layout members
  | Extension { name = n; layout; members } ->
      type_decl b ~doc ~mods ~keyword:"extension" ~name:n ~generics:[]
        ~inherits:[] ~layout members
  | Typealias { name = n; type_ = t } ->
      let o = visit b in
      let ms = modifiers b o mods in
      let keyword = tok b "typealias" in
      after b o keyword [ continue_ ];
      ignore (tok b (name n));
      let equal = tok b "=" in
      let oi = visit b in
      before b oi equal [ space ];
      after b oi equal [ continue_ ];
      let ty = type_ b t in
      let first = match ms with m :: _ -> m | [] -> keyword in
      doc_comment first doc;
      span first ty.last Other
  | Property { var; name = n; type_ = t; value } ->
      let o = visit b in
      let ms = modifiers b o mods in
      let keyword = tok b (if var then "var" else "let") in
      after b o keyword [ space ];
      let last = binding b ~name:n ~type_:t ~value in
      let first = match ms with m :: _ -> m | [] -> keyword in
      doc_comment first doc;
      span first last Other
  | Computed { name = n; type_ = t; body } ->
      let o = visit b in
      let ms = modifiers b o mods in
      let keyword = tok b "var" in
      after b o keyword [ space ];
      let ob = visit b in
      ignore (tok b (name n));
      let colon = tok b ":" in
      after b ob colon
        [ break_ ~newline:ignoring (L.Open_break L.Continuation) ];
      let ot = visit b in
      let ty = type_ b t in
      before b ot ty.first [ group ];
      after b ot ty.last [ L.Close ];
      after b ob ty.last [ close_must 0 ];
      let close = code_block b ob ~reset:true body in
      let first = match ms with m :: _ -> m | [] -> keyword in
      doc_comment first doc;
      span first close Other
  | Init { params; throws; body } ->
      function_like b ~doc ~mods ~keyword:"init" ~name:None ~generics:[] ~params
        ~throws ~result:None body
  | Func { name = n; generics; params; throws; result; body } ->
      function_like b ~doc ~mods ~keyword:"func" ~name:(Some n) ~generics
        ~params ~throws ~result body
  | Case { name = n; value } ->
      let o = visit b in
      let keyword = tok b "case" in
      after b o keyword [ continue_ ];
      let name_tok = tok b (name n) in
      let last =
        match value with
        | Bare -> name_tok
        | Raw v ->
            let equal = tok b "=" in
            let oi = visit b in
            before b oi equal [ space ];
            after b oi equal [ continue_ ];
            (expr b ~place:Top v).last
        | Associated types ->
            let oc = visit b in
            let open_ = tok b "(" in
            let ol = visit b in
            let ts =
              entries b
                (fun t ->
                  let n = type_ b t in
                  (n, n.last))
                types
            in
            let close = tok b ")" in
            after b oc open_ [ open_block0; group ];
            before b oc close [ close_free; L.Close ];
            delimited b ol ~grouped:false ~collection:false ts;
            List.iter
              (fun ((t : node), _) ->
                let op = visit b in
                before b op t.first [ group ];
                after b op t.last [ L.Close ])
              ts;
            close
      in
      before b o keyword [ group ];
      after b o last [ L.Close ];
      doc_comment keyword doc;
      span keyword last Other

(* swift-format's arrangeTypeDeclBlock. *)
and type_decl b ~doc ~mods ~keyword ~name:n ~generics ~inherits ~layout members
    =
  let o = visit b in
  let ms = modifiers b o mods in
  let keyword_tok = tok b keyword in
  after b o keyword_tok [ continue_ ];
  let name_tok = tok b (name n) in
  let generic_close = generic_parameters b generics in
  let before_brace =
    match inherits with
    | [] -> Option.value generic_close ~default:name_tok
    | _ ->
        let colon = tok b ":" in
        let oi = visit b in
        let ts =
          entries b
            (fun t ->
              let n = type_ b t in
              (n, n.last))
            inherits
        in
        let first = (fst (List.hd ts)).first in
        let last = snd (List.nth ts (List.length ts - 1)) in
        before b oi first [ group; open_block ];
        after b oi last [ close_must 0; L.Close ];
        let ol = visit b in
        let count = List.length ts in
        List.iteri
          (fun i (t, _) -> if i < count - 1 then after b ol t.last [ same ])
          ts;
        colon
  in
  let first = match ms with m :: _ -> m | [] -> keyword_tok in
  before b o first [ group ];
  before b o first [ group ];
  after b o before_brace [ L.Close ];
  let open_ = tok b "{" in
  let held = items b layout members (decl b) in
  let close = tok b "}" in
  if layout = Lines then close.newlines <- 1;
  braces b o ~reset:true
    ~newline:(L.Elective { ignores_discretionary = false })
    ~empty:(not held) open_ close;
  after b o close [ L.Close ];
  doc_comment first doc;
  span first close Other

(* swift-format's FunctionDecl and InitializerDecl visits. *)
and function_like b ~doc ~mods ~keyword ~name:n ~generics ~params ~throws
    ~result body =
  let o = visit b in
  let ms = modifiers b o mods in
  let keyword_tok = tok b keyword in
  (match n with
  | Some n ->
      after b o keyword_tok [ continue_ ];
      let name_tok = tok b (if List.mem n operators then n else name n) in
      if List.mem n operators then after b o name_tok [ space ]
  | None -> ());
  ignore (generic_parameters b generics);
  let open_, close, any = parameters b o ~body:true params in
  if any then after b o open_ [ L.Close ] else after b o close [ L.Close ];
  if throws then before b o (tok b "throws") [ continue_ ];
  Option.iter
    (fun r ->
      let arrow = tok b "->" in
      before b o arrow [ continue_ ];
      after b o arrow [ space ];
      ignore (type_ b r))
    result;
  let first = match ms with m :: _ -> m | [] -> keyword_tok in
  before b o first [ group ];
  before b o first [ group ];
  let close = code_block b o ~reset:true body in
  after b o close [ L.Close ];
  doc_comment first doc;
  span first close Other

(* Emitting: each token's insertions in their order, its newlines merged
   into the break before it where nothing printed comes between, and its
   comment after the groups that open on it. *)

let merge newline count =
  match newline with
  | L.Elective _ -> L.Soft { count; discretionary = true }
  | L.Soft { count = c; discretionary = true } ->
      L.Soft { count = c + count; discretionary = true }
  | L.Soft { discretionary = false; _ } ->
      L.Soft { count; discretionary = true }

let emit toks =
  let out = Dynarray.create () in
  let target = ref None and mergeable = ref false and last_kind = ref None in
  let push token =
    (match token with
    | L.Break { kind = L.Close_break _ as kind; _ } -> last_kind := Some kind
    | L.Break { kind; _ } ->
        last_kind := Some kind;
        target := Some (Dynarray.length out);
        mergeable := true
    | L.Open _ | L.Context_start | L.Context_end | L.Disable_breaking
    | L.Enable_breaking | L.Comma_start | L.Comma_end _ ->
        ()
    | L.Syntax _ | L.Space _ | L.Comment _ | L.Close -> mergeable := false);
    Dynarray.add_last out token
  in
  (* Merge [count] newlines into the last break pushed. *)
  let merge_last count =
    match !target with
    | Some i -> (
        match Dynarray.get out i with
        | L.Break { kind; size; newline } ->
            Dynarray.set out i
              (L.Break { kind; size; newline = merge newline count })
        | _ -> ())
    | None -> ()
  in
  let newline_break count =
    L.Break
      {
        kind = L.Same;
        size = 0;
        newline = L.Soft { count; discretionary = true };
      }
  in
  let deferred = ref [] in
  let emit_afters t =
    List.iter
      (fun (_, tokens) -> List.iter push tokens)
      (List.sort (fun (a, _) (b, _) -> compare b a) t.afters)
  in
  Array.iteri
    (fun i t ->
      let pending =
        if t.newlines = 0 then ref 0
        else if !mergeable then (
          merge_last t.newlines;
          ref 0)
        else ref t.newlines
      in
      let comment = ref t.comment in
      let put_comment () =
        match !comment with
        | Some (kind, lines) ->
            if !pending > 0 then (
              push (newline_break !pending);
              pending := 0);
            push (L.Comment { kind; lines });
            push (newline_break 1);
            comment := None
        | None -> ()
      in
      List.iter
        (fun (_, tokens) ->
          List.iter
            (fun token ->
              match token with
              | L.Open _ -> push token
              | L.Break { kind; size; newline } when !pending > 0 -> (
                  match kind with
                  | L.Close_break _ ->
                      (* The newlines before a closing delimiter break as
                         the last break before them does. *)
                      let kind =
                        match !last_kind with
                        | Some
                            ((L.Continue | L.Same | L.Reset | L.Contextual) as
                             kind) ->
                            kind
                        | _ -> L.Same
                      in
                      push
                        (L.Break
                           {
                             kind;
                             size = 0;
                             newline =
                               L.Soft { count = !pending; discretionary = true };
                           });
                      pending := 0;
                      put_comment ();
                      push token
                  | _ ->
                      put_comment ();
                      if !pending > 0 then (
                        push
                          (L.Break
                             { kind; size; newline = merge newline !pending });
                        pending := 0)
                      else push token)
              | _ ->
                  if !pending > 0 then (
                    push (newline_break !pending);
                    pending := 0);
                  put_comment ();
                  push token)
            tokens)
        (List.sort (fun (a, _) (b, _) -> compare a b) t.befores);
      if !pending > 0 then push (newline_break !pending);
      put_comment ();
      push (L.Syntax t.text);
      if t.closing_delimiter <> None then (
        List.iter push !deferred;
        deferred := []);
      match
        if i + 1 < Array.length toks then toks.(i + 1).closing_delimiter
        else None
      with
      | Some delimited ->
          let inner, own =
            List.partition (fun ((order, _), _) -> order > delimited) t.afters
          in
          emit_afters { t with afters = own };
          deferred :=
            List.concat_map snd
              (List.sort (fun (a, _) (b, _) -> compare b a) inner)
      | None -> emit_afters t)
    toks;
  Dynarray.to_list out

let tokens { banner; imports; decls } =
  let b = { toks = []; count = 0; order = 0; seq = 0 } in
  let o = visit b in
  let lowered_imports =
    List.mapi
      (fun i { module_; testable } ->
        let oi = visit b in
        let oimport = visit b in
        let first =
          if testable then (
            let ol = visit b in
            let oa = visit b in
            let at = tok b "@" in
            let word = tok b "testable" in
            before b ol at [ group ];
            before b oa at [ group ];
            after b oa word [ L.Close ];
            after b ol word [ L.Close; same ];
            at)
          else tok b "import"
        in
        let keyword = if testable then tok b "import" else first in
        after b oimport keyword [ space ];
        let last = tok b (name module_) in
        before b oimport first [ L.Disable_breaking ];
        after b oimport last [ L.Enable_breaking ];
        before b oi first [ group ];
        after b oi last [ L.Close ];
        after b o last [ break_ ~size:0 L.Reset ];
        (if i = 0 then
           first.comment <-
             Some (L.Line_comment, List.map (fun l -> "// " ^ l) banner)
         else
           let previous = List.nth imports (i - 1) in
           first.newlines <-
             (if testable && not previous.testable then 2 else 1));
        first)
      imports
  in
  ignore lowered_imports;
  List.iter
    (fun (gap, d) ->
      let oi = visit b in
      let n = decl b d in
      before b oi n.first [ group ];
      after b oi n.last [ L.Close ];
      after b o n.last [ break_ ~size:0 L.Reset ];
      n.first.newlines <- (match gap with Line -> 1 | Blank -> 2))
    decls;
  let eof = tok b "" in
  after b o eof
    [ break_ ~newline:(L.Soft { count = 1; discretionary = false }) L.Same ];
  let toks = Array.of_list (List.rev b.toks) in
  emit toks

let print file = L.print (tokens file)
