external try_exclusive : Unix.file_descr -> bool = "xynoplex_probe_try_flock"
external unlock : Unix.file_descr -> unit = "xynoplex_probe_unlock"
