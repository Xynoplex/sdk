(* Generated from string enums in protocol/specs/src/components/schemas. Do not edit.
   Regenerate: make generate (codegen/lib/ocaml_sdk/enums.ml) *)

let () =
  let module Model = Xynolog.Enums.Body_purpose in
  Alcotest.check Alcotest.string "Body_purpose encode" "assessing"
    (Model.to_string Model.Assessing);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "assessing" = Some Model.Assessing);
  Alcotest.check Alcotest.string "Body_purpose encode" "bookmarking"
    (Model.to_string Model.Bookmarking);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "bookmarking" = Some Model.Bookmarking);
  Alcotest.check Alcotest.string "Body_purpose encode" "classifying"
    (Model.to_string Model.Classifying);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "classifying" = Some Model.Classifying);
  Alcotest.check Alcotest.string "Body_purpose encode" "commenting"
    (Model.to_string Model.Commenting);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "commenting" = Some Model.Commenting);
  Alcotest.check Alcotest.string "Body_purpose encode" "describing"
    (Model.to_string Model.Describing);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "describing" = Some Model.Describing);
  Alcotest.check Alcotest.string "Body_purpose encode" "editing"
    (Model.to_string Model.Editing);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "editing" = Some Model.Editing);
  Alcotest.check Alcotest.string "Body_purpose encode" "highlighting"
    (Model.to_string Model.Highlighting);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "highlighting" = Some Model.Highlighting);
  Alcotest.check Alcotest.string "Body_purpose encode" "identifying"
    (Model.to_string Model.Identifying);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "identifying" = Some Model.Identifying);
  Alcotest.check Alcotest.string "Body_purpose encode" "linking"
    (Model.to_string Model.Linking);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "linking" = Some Model.Linking);
  Alcotest.check Alcotest.string "Body_purpose encode" "moderating"
    (Model.to_string Model.Moderating);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "moderating" = Some Model.Moderating);
  Alcotest.check Alcotest.string "Body_purpose encode" "questioning"
    (Model.to_string Model.Questioning);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "questioning" = Some Model.Questioning);
  Alcotest.check Alcotest.string "Body_purpose encode" "replying"
    (Model.to_string Model.Replying);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "replying" = Some Model.Replying);
  Alcotest.check Alcotest.string "Body_purpose encode" "tagging"
    (Model.to_string Model.Tagging);
  Alcotest.check Alcotest.bool "Body_purpose decode" true
    (Model.of_string "tagging" = Some Model.Tagging);
  Alcotest.check Alcotest.bool "Body_purpose rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Durability_evidence in
  Alcotest.check Alcotest.string "Durability_evidence encode" "acknowledged"
    (Model.to_string Model.Acknowledged);
  Alcotest.check Alcotest.bool "Durability_evidence decode" true
    (Model.of_string "acknowledged" = Some Model.Acknowledged);
  Alcotest.check Alcotest.string "Durability_evidence encode" "probe-confirmed"
    (Model.to_string Model.Probe_confirmed);
  Alcotest.check Alcotest.bool "Durability_evidence decode" true
    (Model.of_string "probe-confirmed" = Some Model.Probe_confirmed);
  Alcotest.check Alcotest.string "Durability_evidence encode" "probe-refused"
    (Model.to_string Model.Probe_refused);
  Alcotest.check Alcotest.bool "Durability_evidence decode" true
    (Model.of_string "probe-refused" = Some Model.Probe_refused);
  Alcotest.check Alcotest.string "Durability_evidence encode"
    "probe-unreachable"
    (Model.to_string Model.Probe_unreachable);
  Alcotest.check Alcotest.bool "Durability_evidence decode" true
    (Model.of_string "probe-unreachable" = Some Model.Probe_unreachable);
  Alcotest.check Alcotest.bool "Durability_evidence rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Failure_class in
  Alcotest.check Alcotest.string "Failure_class encode" "transient"
    (Model.to_string Model.Transient);
  Alcotest.check Alcotest.bool "Failure_class decode" true
    (Model.of_string "transient" = Some Model.Transient);
  Alcotest.check Alcotest.string "Failure_class encode" "deterministic"
    (Model.to_string Model.Deterministic);
  Alcotest.check Alcotest.bool "Failure_class decode" true
    (Model.of_string "deterministic" = Some Model.Deterministic);
  Alcotest.check Alcotest.string "Failure_class encode" "withheld"
    (Model.to_string Model.Withheld);
  Alcotest.check Alcotest.bool "Failure_class decode" true
    (Model.of_string "withheld" = Some Model.Withheld);
  Alcotest.check Alcotest.bool "Failure_class rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Job_type in
  Alcotest.check Alcotest.string "Job_type encode" "mark"
    (Model.to_string Model.Mark);
  Alcotest.check Alcotest.bool "Job_type decode" true
    (Model.of_string "mark" = Some Model.Mark);
  Alcotest.check Alcotest.string "Job_type encode" "yield"
    (Model.to_string Model.Yield);
  Alcotest.check Alcotest.bool "Job_type decode" true
    (Model.of_string "yield" = Some Model.Yield);
  Alcotest.check Alcotest.bool "Job_type rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Log_format in
  Alcotest.check Alcotest.string "Log_format encode" "json"
    (Model.to_string Model.Json);
  Alcotest.check Alcotest.bool "Log_format decode" true
    (Model.of_string "json" = Some Model.Json);
  Alcotest.check Alcotest.string "Log_format encode" "simple"
    (Model.to_string Model.Simple);
  Alcotest.check Alcotest.bool "Log_format decode" true
    (Model.of_string "simple" = Some Model.Simple);
  Alcotest.check Alcotest.bool "Log_format rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Log_level in
  Alcotest.check Alcotest.string "Log_level encode" "error"
    (Model.to_string Model.Error);
  Alcotest.check Alcotest.bool "Log_level decode" true
    (Model.of_string "error" = Some Model.Error);
  Alcotest.check Alcotest.string "Log_level encode" "warn"
    (Model.to_string Model.Warn);
  Alcotest.check Alcotest.bool "Log_level decode" true
    (Model.of_string "warn" = Some Model.Warn);
  Alcotest.check Alcotest.string "Log_level encode" "info"
    (Model.to_string Model.Info);
  Alcotest.check Alcotest.bool "Log_level decode" true
    (Model.of_string "info" = Some Model.Info);
  Alcotest.check Alcotest.string "Log_level encode" "http"
    (Model.to_string Model.Http);
  Alcotest.check Alcotest.bool "Log_level decode" true
    (Model.of_string "http" = Some Model.Http);
  Alcotest.check Alcotest.string "Log_level encode" "debug"
    (Model.to_string Model.Debug);
  Alcotest.check Alcotest.bool "Log_level decode" true
    (Model.of_string "debug" = Some Model.Debug);
  Alcotest.check Alcotest.bool "Log_level rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Motivation in
  Alcotest.check Alcotest.string "Motivation encode" "assessing"
    (Model.to_string Model.Assessing);
  Alcotest.check Alcotest.bool "Motivation decode" true
    (Model.of_string "assessing" = Some Model.Assessing);
  Alcotest.check Alcotest.string "Motivation encode" "commenting"
    (Model.to_string Model.Commenting);
  Alcotest.check Alcotest.bool "Motivation decode" true
    (Model.of_string "commenting" = Some Model.Commenting);
  Alcotest.check Alcotest.string "Motivation encode" "highlighting"
    (Model.to_string Model.Highlighting);
  Alcotest.check Alcotest.bool "Motivation decode" true
    (Model.of_string "highlighting" = Some Model.Highlighting);
  Alcotest.check Alcotest.string "Motivation encode" "linking"
    (Model.to_string Model.Linking);
  Alcotest.check Alcotest.bool "Motivation decode" true
    (Model.of_string "linking" = Some Model.Linking);
  Alcotest.check Alcotest.string "Motivation encode" "tagging"
    (Model.to_string Model.Tagging);
  Alcotest.check Alcotest.bool "Motivation decode" true
    (Model.of_string "tagging" = Some Model.Tagging);
  Alcotest.check Alcotest.bool "Motivation rejects unknown values" true
    (Model.of_string "" = None);
  let module Model = Xynolog.Enums.Supported_media_type in
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/plain"
    (Model.to_string Model.Text_plain);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/plain" = Some Model.Text_plain);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/markdown"
    (Model.to_string Model.Text_markdown);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/markdown" = Some Model.Text_markdown);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/html"
    (Model.to_string Model.Text_html);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/html" = Some Model.Text_html);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/css"
    (Model.to_string Model.Text_css);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/css" = Some Model.Text_css);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/csv"
    (Model.to_string Model.Text_csv);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/csv" = Some Model.Text_csv);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/xml"
    (Model.to_string Model.Text_xml);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/xml" = Some Model.Text_xml);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/json"
    (Model.to_string Model.Application_json);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/json" = Some Model.Application_json);
  Alcotest.check Alcotest.string "Supported_media_type encode" "application/xml"
    (Model.to_string Model.Application_xml);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/xml" = Some Model.Application_xml);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/yaml"
    (Model.to_string Model.Application_yaml);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/yaml" = Some Model.Application_yaml);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/x-yaml"
    (Model.to_string Model.Application_x_yaml);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/x-yaml" = Some Model.Application_x_yaml);
  Alcotest.check Alcotest.string "Supported_media_type encode" "application/pdf"
    (Model.to_string Model.Application_pdf);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/pdf" = Some Model.Application_pdf);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/msword"
    (Model.to_string Model.Application_msword);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/msword" = Some Model.Application_msword);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    (Model.to_string
       Model
       .Application_vnd_openxmlformats_officedocument_wordprocessingml_document);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string
       "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    = Some
        Model
        .Application_vnd_openxmlformats_officedocument_wordprocessingml_document
    );
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/vnd.ms-excel"
    (Model.to_string Model.Application_vnd_ms_excel);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/vnd.ms-excel"
    = Some Model.Application_vnd_ms_excel);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    (Model.to_string
       Model.Application_vnd_openxmlformats_officedocument_spreadsheetml_sheet);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string
       "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    = Some
        Model.Application_vnd_openxmlformats_officedocument_spreadsheetml_sheet
    );
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/vnd.ms-powerpoint"
    (Model.to_string Model.Application_vnd_ms_powerpoint);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/vnd.ms-powerpoint"
    = Some Model.Application_vnd_ms_powerpoint);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    (Model.to_string
       Model
       .Application_vnd_openxmlformats_officedocument_presentationml_presentation);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string
       "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    = Some
        Model
        .Application_vnd_openxmlformats_officedocument_presentationml_presentation
    );
  Alcotest.check Alcotest.string "Supported_media_type encode" "application/zip"
    (Model.to_string Model.Application_zip);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/zip" = Some Model.Application_zip);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/gzip"
    (Model.to_string Model.Application_gzip);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/gzip" = Some Model.Application_gzip);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/x-tar"
    (Model.to_string Model.Application_x_tar);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/x-tar" = Some Model.Application_x_tar);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/x-7z-compressed"
    (Model.to_string Model.Application_x_7z_compressed);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/x-7z-compressed"
    = Some Model.Application_x_7z_compressed);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/octet-stream"
    (Model.to_string Model.Application_octet_stream);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/octet-stream"
    = Some Model.Application_octet_stream);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/wasm"
    (Model.to_string Model.Application_wasm);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/wasm" = Some Model.Application_wasm);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/png"
    (Model.to_string Model.Image_png);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/png" = Some Model.Image_png);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/jpeg"
    (Model.to_string Model.Image_jpeg);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/jpeg" = Some Model.Image_jpeg);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/gif"
    (Model.to_string Model.Image_gif);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/gif" = Some Model.Image_gif);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/webp"
    (Model.to_string Model.Image_webp);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/webp" = Some Model.Image_webp);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/svg+xml"
    (Model.to_string Model.Image_svg_plusxml);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/svg+xml" = Some Model.Image_svg_plusxml);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/bmp"
    (Model.to_string Model.Image_bmp);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/bmp" = Some Model.Image_bmp);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/tiff"
    (Model.to_string Model.Image_tiff);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/tiff" = Some Model.Image_tiff);
  Alcotest.check Alcotest.string "Supported_media_type encode" "image/x-icon"
    (Model.to_string Model.Image_x_icon);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "image/x-icon" = Some Model.Image_x_icon);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/mp4"
    (Model.to_string Model.Video_mp4);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/mp4" = Some Model.Video_mp4);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/mpeg"
    (Model.to_string Model.Video_mpeg);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/mpeg" = Some Model.Video_mpeg);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/webm"
    (Model.to_string Model.Video_webm);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/webm" = Some Model.Video_webm);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/ogg"
    (Model.to_string Model.Video_ogg);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/ogg" = Some Model.Video_ogg);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/quicktime"
    (Model.to_string Model.Video_quicktime);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/quicktime" = Some Model.Video_quicktime);
  Alcotest.check Alcotest.string "Supported_media_type encode" "video/x-msvideo"
    (Model.to_string Model.Video_x_msvideo);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "video/x-msvideo" = Some Model.Video_x_msvideo);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/mpeg"
    (Model.to_string Model.Audio_mpeg);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/mpeg" = Some Model.Audio_mpeg);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/wav"
    (Model.to_string Model.Audio_wav);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/wav" = Some Model.Audio_wav);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/ogg"
    (Model.to_string Model.Audio_ogg);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/ogg" = Some Model.Audio_ogg);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/webm"
    (Model.to_string Model.Audio_webm);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/webm" = Some Model.Audio_webm);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/aac"
    (Model.to_string Model.Audio_aac);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/aac" = Some Model.Audio_aac);
  Alcotest.check Alcotest.string "Supported_media_type encode" "audio/flac"
    (Model.to_string Model.Audio_flac);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "audio/flac" = Some Model.Audio_flac);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/javascript"
    (Model.to_string Model.Text_javascript);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/javascript" = Some Model.Text_javascript);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/javascript"
    (Model.to_string Model.Application_javascript);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/javascript"
    = Some Model.Application_javascript);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "text/x-typescript"
    (Model.to_string Model.Text_x_typescript);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-typescript" = Some Model.Text_x_typescript);
  Alcotest.check Alcotest.string "Supported_media_type encode"
    "application/typescript"
    (Model.to_string Model.Application_typescript);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "application/typescript"
    = Some Model.Application_typescript);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-python"
    (Model.to_string Model.Text_x_python);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-python" = Some Model.Text_x_python);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-java"
    (Model.to_string Model.Text_x_java);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-java" = Some Model.Text_x_java);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-c"
    (Model.to_string Model.Text_x_c);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-c" = Some Model.Text_x_c);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-c++"
    (Model.to_string Model.Text_x_c_plus_plus);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-c++" = Some Model.Text_x_c_plus_plus);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-csharp"
    (Model.to_string Model.Text_x_csharp);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-csharp" = Some Model.Text_x_csharp);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-go"
    (Model.to_string Model.Text_x_go);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-go" = Some Model.Text_x_go);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-rust"
    (Model.to_string Model.Text_x_rust);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-rust" = Some Model.Text_x_rust);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-ruby"
    (Model.to_string Model.Text_x_ruby);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-ruby" = Some Model.Text_x_ruby);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-php"
    (Model.to_string Model.Text_x_php);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-php" = Some Model.Text_x_php);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-swift"
    (Model.to_string Model.Text_x_swift);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-swift" = Some Model.Text_x_swift);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-kotlin"
    (Model.to_string Model.Text_x_kotlin);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-kotlin" = Some Model.Text_x_kotlin);
  Alcotest.check Alcotest.string "Supported_media_type encode" "text/x-shell"
    (Model.to_string Model.Text_x_shell);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "text/x-shell" = Some Model.Text_x_shell);
  Alcotest.check Alcotest.string "Supported_media_type encode" "font/woff"
    (Model.to_string Model.Font_woff);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "font/woff" = Some Model.Font_woff);
  Alcotest.check Alcotest.string "Supported_media_type encode" "font/woff2"
    (Model.to_string Model.Font_woff2);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "font/woff2" = Some Model.Font_woff2);
  Alcotest.check Alcotest.string "Supported_media_type encode" "font/ttf"
    (Model.to_string Model.Font_ttf);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "font/ttf" = Some Model.Font_ttf);
  Alcotest.check Alcotest.string "Supported_media_type encode" "font/otf"
    (Model.to_string Model.Font_otf);
  Alcotest.check Alcotest.bool "Supported_media_type decode" true
    (Model.of_string "font/otf" = Some Model.Font_otf);
  Alcotest.check Alcotest.bool "Supported_media_type rejects unknown values"
    true
    (Model.of_string "" = None);
  ()
