(* A schema's [allOf] merged into the one object it describes, as the Haskell
   SDK's Xynolog.Internal.Schema.normalize merges it at run time: each part,
   a reference expanded, merged keyword by keyword, then the schema's own
   keywords on top. Bounds tighten, [required] and [enum] combine, a closed
   object stays closed, and keywords that must agree are refused when they
   don't; any other keyword is the last part's. A property two parts state
   differently is the [allOf] of both. *)

type 'a outcome = ('a, string) result

let ( let* ) = Result.bind

(* A reference names the schema of its file's base name. *)
let referenced (r : Decode.reference) =
  Filename.remove_extension (Filename.basename r.target)

let agree what left right =
  if left = right then Ok right
  else Error ("unsupported intersection of " ^ what)

let merge_option combine old next =
  match (old, next) with
  | None, next -> Ok next
  | old, None -> Ok old
  | Some old, Some next -> Result.map Option.some (combine old next)

let union_properties old next =
  let intersection left right =
    if left = right then left
    else Schema.Schema { Schema.empty with all_of = Some [ left; right ] }
  in
  let keys =
    List.sort_uniq String.compare (List.map fst old @ List.map fst next)
  in
  Ok
    (List.map
       (fun key ->
         match (List.assoc_opt key old, List.assoc_opt key next) with
         | Some l, Some r -> (key, intersection l r)
         | Some s, None | None, Some s -> (key, s)
         | None, None -> assert false)
       keys)

let distinct names =
  List.rev
    (List.fold_left
       (fun kept n -> if List.mem n kept then kept else n :: kept)
       [] names)

(* [next]'s keywords merged onto [old]'s. *)
let merge (old : Schema.schema) (next : Schema.schema) : Schema.schema outcome =
  let last old next = Ok (match next with None -> old | Some _ -> next) in
  let bound pick = merge_option (fun l r -> Ok (pick l r)) in
  let* properties =
    merge_option union_properties old.properties next.properties
  in
  let* required =
    merge_option (fun l r -> Ok (distinct (l @ r))) old.required next.required
  in
  let* enum =
    merge_option
      (fun l r ->
        match List.filter (fun v -> List.mem v r) l with
        | [] -> Error "empty enum intersection"
        | common -> Ok common)
      old.enum next.enum
  in
  let* type_ =
    merge_option
      (fun l r ->
        if l = r then Ok r else Error "incompatible intersection types")
      old.type_ next.type_
  in
  let* additional_properties =
    match old.additional_properties with
    | Some (Boolean_schema false) -> Ok old.additional_properties
    | _ -> last old.additional_properties next.additional_properties
  in
  let* unique_items =
    match old.unique_items with
    | Some true -> Ok old.unique_items
    | _ -> last old.unique_items next.unique_items
  in
  let* pattern = merge_option (agree "\"pattern\"") old.pattern next.pattern in
  let* one_of = merge_option (agree "\"oneOf\"") old.one_of next.one_of in
  let* any_of = merge_option (agree "\"anyOf\"") old.any_of next.any_of in
  let* items = merge_option (agree "\"items\"") old.items next.items in
  let* ref_ = merge_option (agree "\"$ref\"") old.ref_ next.ref_ in
  let* minimum = bound Float.max old.minimum next.minimum in
  let* maximum = bound Float.min old.maximum next.maximum in
  let* min_length = bound Int.max old.min_length next.min_length in
  let* min_items = bound Int.max old.min_items next.min_items in
  let* max_length = bound Int.min old.max_length next.max_length in
  let* max_items = bound Int.min old.max_items next.max_items in
  let* max_properties = bound Int.min old.max_properties next.max_properties in
  let* comment = last old.comment next.comment in
  let* title = last old.title next.title in
  let* description = last old.description next.description in
  let* format = last old.format next.format in
  let* const = last old.const next.const in
  let* default = last old.default next.default in
  let* example = last old.example next.example in
  let* nullable = last old.nullable next.nullable in
  let* property_names = last old.property_names next.property_names in
  let* min_properties = last old.min_properties next.min_properties in
  let* all_of = last old.all_of next.all_of in
  let* not_ = last old.not_ next.not_ in
  let* discriminator = last old.discriminator next.discriminator in
  Ok
    {
      Schema.ref_;
      comment;
      title;
      description;
      type_;
      format;
      enum;
      const;
      default;
      example;
      nullable;
      properties;
      required;
      additional_properties;
      property_names;
      min_properties;
      max_properties;
      items;
      min_items;
      max_items;
      unique_items;
      min_length;
      max_length;
      pattern;
      minimum;
      maximum;
      all_of;
      any_of;
      one_of;
      not_;
      discriminator;
    }

let layer : Schema.t -> Schema.schema outcome = function
  | Schema s -> Ok s
  | Boolean_schema _ -> Error "expected a schema object"

(* A schema expanded as the whole that is normalized, and as a part of an
   [allOf]: a part that refers to a schema is that schema expanded, with the
   part's own keywords on top. Each is given the references the expansion is
   within, so a schema that is a part of itself is refused. *)
type expansion = {
  whole : string list -> Schema.schema outcome;
  part : string list -> Schema.schema outcome;
}

(* [schema] with its [allOf] merged, each reference in it found by [find]. *)
let normalize ~find schema =
  let rec expand schema =
    Schema.para
      ~boolean:(fun b ->
        let refused _ = layer (Schema.Boolean_schema b) in
        { whole = refused; part = refused })
      ~schema:(fun l ->
        let s = Schema.map fst l in
        let whole trail =
          match l.all_of with
          | None -> Ok s
          | Some parts ->
              let* merged =
                List.fold_left
                  (fun merged (_, p) ->
                    let* merged = merged in
                    let* p = p.part trail in
                    merge merged p)
                  (Ok Schema.empty) parts
              in
              merge merged { s with all_of = None }
        in
        let part trail =
          match s.ref_ with
          | Some r ->
              let* () =
                if List.mem r.target trail then
                  Error ("cyclic schema intersection: " ^ r.target)
                else Ok ()
              in
              let* target = find (referenced r) in
              let* expanded = (expand target).whole (r.target :: trail) in
              merge expanded { s with ref_ = None }
          | None -> whole trail
        in
        { whole; part })
      schema
  in
  (expand schema).whole []
