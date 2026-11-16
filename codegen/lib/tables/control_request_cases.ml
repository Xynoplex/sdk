(* specs/src/control/request-cases.json *)

type id = Int of int | String of string

let id =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : id)
  | Decode.String -> (String (Decode.string c) : id)
  | _ -> Decode.refuse c "expected an integer or a string"

type data = {
  code : string;
  retryable : bool;
  fields : string list option;
  supported : string list option;
}

let data =
  Decode.obj (fun o : data ->
      {
        code = Decode.required o "code" Decode.string;
        retryable = Decode.required o "retryable" Decode.bool;
        fields = Decode.optional o "fields" (Decode.list Decode.string);
        supported = Decode.optional o "supported" (Decode.list Decode.string);
      })

type error = { code : int; data : data option }

let error =
  Decode.obj (fun o : error ->
      {
        code = Decode.required o "code" Decode.int;
        data = Decode.optional o "data" data;
      })

type answer = { id : id option; result : bool option; error : error option }

let answer =
  Decode.obj (fun o : answer ->
      {
        id = Decode.required o "id" (Decode.nullable id);
        result = Decode.optional o "result" Decode.bool;
        error = Decode.optional o "error" error;
      })

type case = { name : string; line : string; answer : answer option }

let case =
  Decode.obj (fun o : case ->
      {
        name = Decode.required o "name" Decode.string;
        line = Decode.required o "line" Decode.string;
        answer = Decode.required o "answer" (Decode.nullable answer);
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
