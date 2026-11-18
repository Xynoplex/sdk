(* The Kotlin names the SDK's generated code gives what Protocol names. A
   name that cannot be one is refused, with why. *)

exception Refused of string

let refuse fmt = Printf.ksprintf (fun m -> raise (Refused m)) fmt

let is_letter_or_digit = function
  | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' -> true
  | _ -> false

(* [in-process] and [subjectClaim] as [InProcess] and [SubjectClaim]. *)
let pascal word =
  let out = Buffer.create (String.length word) in
  let upper = ref true in
  String.iter
    (fun c ->
      if is_letter_or_digit c then (
        Buffer.add_char out (if !upper then Char.uppercase_ascii c else c);
        upper := false)
      else upper := true)
    word;
  Buffer.contents out

let starts_with_digit name =
  name <> "" && match name.[0] with '0' .. '9' -> true | _ -> false

(* A property's Kotlin name, from the name the wire gives it: JSON-LD's [@]
   and a stamp's leading [_] dropped, and a word that a [_] or [-] begins
   capitalised ([_userId] is [userId], [email_sha1] is [emailSha1]). *)
let property_name wire =
  let rec drop i =
    if i < String.length wire && (wire.[i] = '@' || wire.[i] = '_') then
      drop (i + 1)
    else i
  in
  let from = drop 0 in
  let pascal = pascal (String.sub wire from (String.length wire - from)) in
  if pascal = "" || starts_with_digit pascal then
    refuse
      "the property `%s` has no Kotlin name: it must begin with a letter once \
       its `@` or `_` is dropped"
      wire;
  String.make 1 (Char.lowercase_ascii pascal.[0])
  ^ String.sub pascal 1 (String.length pascal - 1)

(* The constant an enumeration's value is. A [+] is part of what a value
   says ([text/x-c++] is not [text/x-c]), so it is spelled. *)
let variant_of value =
  let variant = pascal (Text.replace_all ~sub:"+" ~by:" plus " value) in
  if variant = "" || starts_with_digit variant then
    refuse
      "the enumeration value `%s` has no Kotlin name: it must begin with a \
       letter"
      value;
  variant

(* [beckon:focus] as [BECKON_FOCUS]: upper case, each run of anything but a
   letter or a digit one [_], and none at either end. *)
let constant_name name =
  let upper = String.uppercase_ascii name in
  let out = Buffer.create (String.length upper) in
  let gap = ref false in
  String.iter
    (fun c ->
      match c with
      | 'A' .. 'Z' | '0' .. '9' ->
          if !gap && Buffer.length out > 0 then Buffer.add_char out '_';
          gap := false;
          Buffer.add_char out c
      | _ -> gap := true)
    upper;
  Buffer.contents out

(* A camel-case name's words split before each capital that follows a
   lower-case letter or a digit ([busRequestTimeoutMs] is
   [bus_Request_Timeout_Ms]), and then its constant. *)
let camel_constant name =
  let out = Buffer.create (String.length name + 8) in
  String.iteri
    (fun i c ->
      (match c with
      | 'A' .. 'Z' when i > 0 -> (
          match name.[i - 1] with
          | 'a' .. 'z' | '0' .. '9' -> Buffer.add_char out '_'
          | _ -> ())
      | _ -> ());
      Buffer.add_char out c)
    name;
  constant_name (Buffer.contents out)
