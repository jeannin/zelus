
(*
   ocamlfind ocamlc -o ftscs_example.byte -thread -package z3 -linkpkg ftscs_examples.ml
   ./ftscs_example.byte
*)
open Z3
open Z3.Symbol
open Z3.Sort
open Z3.Expr
open Z3.Boolean
open Z3.FuncDecl
open Z3.Goal
open Z3.Tactic
open Z3.Tactic.ApplyResult
open Z3.Probe
open Z3.Solver
open Z3.Arithmetic
open Z3.Arithmetic.Integer
open Z3.Arithmetic.Real
open Z3.BitVector

let translate_sample_variable ctx s basetype : expr =
    let z3_sort = 
        match basetype with
        | "int" ->   Integer.mk_sort ctx
        | "float" -> FloatingPoint.mk_sort_double ctx
        | "bool" ->  Boolean.mk_sort ctx in
    Expr.mk_const ctx (Symbol.mk_string ctx s) (z3_sort)

    exception TestFailedException of string


let _ = 
      try (
        if not (Log.open_ "z3.log") then
          raise (TestFailedException "Log couldn't be opened.")
        else
          (
        let cfg = [("model", "true"); ("proof", "false")] in
        let ctx = (mk_context cfg) in
        let sample_variable = translate_sample_variable ctx "v" "int" in
        Printf.printf "new variable: %s \n" (Expr.to_string sample_variable);
        Printf.printf "is int: %b \n" (Arithmetic.is_int sample_variable);
        );
        Printf.printf "Exiting.\n" ;
        exit 0
      ) with Error(msg) -> (
        Printf.printf "Z3 EXCEPTION: %s\n" msg ;
        exit 1
      )    
;;
    