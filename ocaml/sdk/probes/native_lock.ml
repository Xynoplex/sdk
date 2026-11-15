external try_exclusive : Unix.file_descr -> bool = "xynolog_probe_try_flock"
external unlock : Unix.file_descr -> unit = "xynolog_probe_unlock"
