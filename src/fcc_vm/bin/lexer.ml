type token =
    | PUSH
    | BIND
    | ID of string
    | NUMBER of int 
    | EOF

(* Main lexer function that returns a list of tokens *)
let rec lexe src toks =
    match src with 
    | [] -> 
        toks @ [EOF]
    | h :: t ->
        match h with
        | "PUSH" -> print_endline "PUSH"; lexe t toks @ [PUSH]
        | "BIND" -> print_endline "BIND"; lexe t toks @ [BIND]
        | _ -> match int_of_string_opt h with
            | Some n -> Printf.printf "NUMBER(%d)\n" n; lexe t toks @ [NUMBER n]
            | None -> Printf.printf "ID(%s)\n" h; lexe t toks @ [ID h]
