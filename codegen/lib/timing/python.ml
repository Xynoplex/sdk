(* The timing as the Python SDK reads it (python/sdk/src/xynolog): a constant
   per entry under its name in upper case, and the names as the table states
   them, by which a caller overrides one. *)

let path = "python/sdk/src/xynolog/timing.py"

let text (t : Table.t) =
  String.concat ""
    [
      Banner.python ~from_:"protocol/specs/src/client/timing.json" __FILE__;
      {|
"""The timing a Xynolog client keeps: its deadlines, its retry budgets, the
cadence of its stream, and what it keeps count of.

Each constant is an entry of the table every SDK generates from, under the
entry's own name: `emitRetry` is `EMIT_RETRY`. `TIMING_NAMES` lists the names
as the table states them, which is how a caller overrides one.
"""

from typing import Final

from xynolog.retry import RetryPolicy

__all__ = [
|};
      String.concat ""
        (List.map
           (fun name -> Printf.sprintf "    %s,\n" (Text.quoted name))
           (List.sort compare
              ("TIMING_NAMES"
              :: List.map (fun (e : Table.entry) -> Text.upper_snake e.name) t)));
      "]\n\n";
      String.concat "\n"
        (List.map
           (fun (e : Table.entry) ->
             Printf.sprintf "%s\n%s: Final = %s\n"
               (Text.python_comment ~indent:"" e.docs)
               (Text.upper_snake e.name)
               (match e.value with
               | Duration n | Count n -> string_of_int n
               | Budget { attempts; initial_delay_ms; max_delay_ms } ->
                   Printf.sprintf
                     "RetryPolicy(attempts=%d, initial_delay_ms=%d, \
                      max_delay_ms=%d)"
                     attempts initial_delay_ms max_delay_ms))
           t);
      "\n\
       # Every entry's name, as the table states it.\n\
       TIMING_NAMES: Final[tuple[str, ...]] = (\n";
      String.concat ""
        (List.map
           (fun (e : Table.entry) ->
             Printf.sprintf "    %s,\n" (Text.quoted e.name))
           t);
      ")\n";
    ]

let file t = { Output.path; text = text t }
