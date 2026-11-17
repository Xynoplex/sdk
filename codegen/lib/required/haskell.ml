(* The table as the Haskell SDK reads it (haskell/sdk/internal/Xynolog/Internal/Required.hs):
   the components' shapes, each bus channel's payload and each HTTP
   operation's reply, as one JSON text in a string literal. Aeson's objects
   keep no order, so an object's members are written as pairs, in the order a
   reader walks them. *)

let path = "haskell/sdk/generated/Xynolog/Internal/Generated/Required.hs"

(* [text] as a Haskell string literal: printable ASCII as itself, a quote and
   a backslash escaped, and every other code point by its number. *)
let literal text =
  let out = Buffer.create (String.length text + 2) in
  Buffer.add_char out '"';
  let rec go i =
    if i < String.length text then (
      let decoded = String.get_utf_8_uchar text i in
      let point = Uchar.to_int (Uchar.utf_decode_uchar decoded) in
      (match point with
      | 0x22 -> Buffer.add_string out "\\\""
      | 0x5C -> Buffer.add_string out "\\\\"
      | p when p >= 0x20 && p <= 0x7E -> Buffer.add_char out (Char.chr p)
      | p -> Buffer.add_string out (Printf.sprintf "\\x%x\\&" p));
      go (i + Uchar.utf_decode_length decoded))
  in
  go 0;
  Buffer.add_char out '"';
  Buffer.contents out

let text ~shapes ~channels ~http =
  let table entries =
    `Assoc
      (List.map
         (fun (name, shape) -> (name, Shape.to_json ~pairs:true shape))
         entries)
  in
  let json =
    `Assoc
      [
        ("schemas", table shapes);
        ("channels", table channels);
        ("http", table http);
      ]
  in
  {|-- Generated from protocol/specs/src's component schemas, bus registry and operations; do not edit.
-- Regenerate: make generate (codegen/lib/required/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Required (shapesJSON) where
import Data.Text (Text)
shapesJSON :: Text
shapesJSON = |}
  ^ literal (Yojson.Safe.to_string json)
  ^ "\n"

let file ~shapes ~channels ~http =
  { Output.path; text = text ~shapes ~channels ~http }
