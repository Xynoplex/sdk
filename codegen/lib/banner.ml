(* The lines a generated file opens with: what it is generated from, and the
   writer that writes it again, named by its own source path ([__FILE__],
   relative to codegen/). *)

let writer file = "codegen/" ^ file

(* The lint rules a generated Python module is exempt from: a long line and an
   ambiguous character are Protocol's prose and data restated, and an order
   of imports or of __all__ is the spec's or the writer's, not isort's; and
   RUF100, since a module need not break each of them. Every other rule holds
   it, as ruff format, the drift gate and the type checkers do.
   python/sdk/scripts/generate_models.py writes the same line. *)
let python_exempt = "# ruff: noqa: E501, I001, RUF002, RUF022, RUF100"

let python ~from_ file =
  "# Generated from " ^ from_ ^ "; do not edit.\n# Regenerate: make generate ("
  ^ writer file ^ ")\n" ^ python_exempt ^ "\n"
