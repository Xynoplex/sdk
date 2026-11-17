(* The timing as the Rust SDK reads it (rust/sdk/src/timing.rs): a constant
   per entry. A duration is a std::time::Duration named without its unit
   ([reconnectMs] is [RECONNECT]), a retry budget a RetryPolicy, and a count
   a usize. *)

module R = Rust_syntax

let path = "rust/sdk/src/generated/timing.rs"
let duration = R.named "std::time::Duration"
let millis n = R.call "std::time::Duration::from_millis" [ R.Int n ]

let constant (e : Table.entry) =
  let name, ty, value =
    match e.value with
    | Duration n ->
        (String.sub e.name 0 (String.length e.name - 2), duration, millis n)
    | Budget { attempts; initial_delay_ms; max_delay_ms } ->
        ( e.name,
          R.named "crate::retry::RetryPolicy",
          R.Struct
            ( [ "crate"; "retry"; "RetryPolicy" ],
              [
                ("attempts", R.Int attempts);
                ("initial_delay", millis initial_delay_ms);
                ("max_delay", millis max_delay_ms);
              ],
              None ) )
    | Count n -> (e.name, R.named "usize", R.Int n)
  in
  R.Const
    {
      doc = [ e.docs ];
      attrs = [];
      vis = Pub;
      name = R.screaming name;
      ty;
      value;
    }

let file (t : Table.t) =
  {
    Output.path;
    text =
      R.text
        ~header:
          (Banner.rust_lines ~from_:"protocol/specs/src/client/timing.json"
             __FILE__)
        (List.map constant t);
  }
