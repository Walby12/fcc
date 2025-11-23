type token =
    | LET
    | EQUALS
    | ID of string
    | NUMBER of int
    | EOF
let map_tok str : token = 
    match str with
        | "let" -> print_endline "LET"; LET
        | _ -> Printf.printf "ID(%s)\n" str; ID str

let rec get_tok src builder index : token =
    if String.length src > 0 then
        let c = src.[index] in
            match c with
                | ' ' -> map_tok builder
                | _ -> match int_of_string_opt (String.make 1 c) with
                    | Some n -> let index = index + 1; get_tok src (builder ^ (string_of_int n)) index
                    | None -> let index = index + 1; get_tok src (builder ^ (String.make 1 c)) index
    else
        EOF
