type t
(** A one-shot upload. Its progress callback runs while [await] sends it: it
    reports [Started] with the file's size before any of it is sent, [Progress]
    as it is sent, and [Finished] with the resource the knowledge base made. An
    answer that names no resource fails the upload, and an upload that fails
    reports no [Finished]. *)

val make : (unit -> (string, Client_core.error) result) -> t
val await : t -> (string, Client_core.error) result
