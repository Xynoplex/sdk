(* How a writer of the sign-in store keeps its directory and its files to
   their owner (sign-in-store/owner-only.json): a mode for the directory, one
   for a file, each four octal digits, and an access list for each, which
   names where the owner's SID goes once. *)

module T = Tables.Sign_in_store_owner_only

let file = "sign-in-store/owner-only.json"
let owner = "{owner}"

type mode = {
  octal : string;  (** The digits after the leading zero. *)
  docs : string;
}

type access_list = {
  before : string;
  after : string;
  docs : string;  (** Naming the owner's place [owner], an argument's name. *)
}

type t = {
  directory : mode;
  file : mode;
  directory_access_list : access_list;
  file_access_list : access_list;
}

let derive (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let mode pointer ~value ~docs =
    let is_octal = function '0' .. '7' -> true | _ -> false in
    if docs = "" then refuse (pointer ^ "/docs") "is empty";
    if
      not
        (String.length value = 4
        && value.[0] = '0'
        && String.for_all is_octal value)
    then
      refuse (pointer ^ "/value")
        (Printf.sprintf "is %S, not four octal digits" value);
    { octal = String.sub value 1 (max 0 (String.length value - 1)); docs }
  in
  let directory =
    mode "/directoryMode" ~value:table.directory_mode.value
      ~docs:table.directory_mode.docs
  in
  let file_mode =
    mode "/fileMode" ~value:table.file_mode.value ~docs:table.file_mode.docs
  in
  let access_list pointer ~value ~docs =
    if docs = "" then refuse (pointer ^ "/docs") "is empty";
    match Text.split ~sub:owner value with
    | [ before; after ] ->
        {
          before;
          after;
          docs = Text.replace_all ~sub:("`" ^ owner ^ "`") ~by:"`owner`" docs;
        }
    | parts ->
        refuse (pointer ^ "/value")
          (Printf.sprintf "names %s %d times, not once" owner
             (List.length parts - 1));
        { before = ""; after = ""; docs = "" }
  in
  let directory_access_list =
    access_list "/directoryAccessList" ~value:table.directory_access_list.value
      ~docs:table.directory_access_list.docs
  in
  let file_access_list =
    access_list "/fileAccessList" ~value:table.file_access_list.value
      ~docs:table.file_access_list.docs
  in
  match List.rev !refusals with
  | [] ->
      Ok
        { directory; file = file_mode; directory_access_list; file_access_list }
  | errors -> Error errors
