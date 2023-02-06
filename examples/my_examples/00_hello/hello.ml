(* Says Hello World by calling a C function *)
external print_hello: unit -> unit = "caml_print_hello"

let () =
    print_hello()