type t = {
  ended : Records.Session_ended.t option State_value.t;
  ended_writer : Records.Session_ended.t option State_value.writer;
  denied : Records.Permission_denied.t option State_value.t;
  denied_writer : Records.Permission_denied.t option State_value.writer;
  conflict : Records.Kb_identity_conflict.t option State_value.t;
  conflict_writer : Records.Kb_identity_conflict.t option State_value.writer;
}

let make () =
  let ended, ended_writer = State_value.make None in
  let denied, denied_writer = State_value.make None in
  let conflict, conflict_writer = State_value.make None in
  { ended; ended_writer; denied; denied_writer; conflict; conflict_writer }

let session_ended t = t.ended
let permission_denied t = t.denied
let kb_identity_conflict t = t.conflict

let notify_session_ended t ~reason =
  State_value.set ~repeat:true t.ended_writer
    (Some { Records.Session_ended.reason })

let notify_permission_denied t ~detail =
  State_value.set ~repeat:true t.denied_writer
    (Some { Records.Permission_denied.detail })

let notify_kb_identity_conflict t conflict =
  State_value.set ~repeat:true t.conflict_writer (Some conflict)

let acknowledge_session_ended t = State_value.set t.ended_writer None
let acknowledge_permission_denied t = State_value.set t.denied_writer None
let acknowledge_kb_identity_conflict t = State_value.set t.conflict_writer None

let dispose t =
  State_value.close t.ended_writer;
  State_value.close t.denied_writer;
  State_value.close t.conflict_writer
