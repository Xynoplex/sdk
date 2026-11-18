type t

val make : unit -> t
val session_ended : t -> Records.Session_ended.t option State_value.t
val permission_denied : t -> Records.Permission_denied.t option State_value.t

val kb_identity_conflict :
  t -> Records.Kb_identity_conflict.t option State_value.t

val notify_session_ended : t -> reason:Enums.Session_end_reason.t -> unit
val notify_permission_denied : t -> detail:string option -> unit
val notify_kb_identity_conflict : t -> Records.Kb_identity_conflict.t -> unit
val acknowledge_session_ended : t -> unit
val acknowledge_permission_denied : t -> unit
val acknowledge_kb_identity_conflict : t -> unit
val dispose : t -> unit
