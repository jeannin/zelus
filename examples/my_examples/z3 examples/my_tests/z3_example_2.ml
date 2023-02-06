(*Z3 check refinement type test*)

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


exception TestFailedException of string


let _ = 
  try (
    if not (Log.open_ "z3.log") then
      raise (TestFailedException "Log couldn't be opened.")
    else
      (
      	Printf.printf "Running Z3 refinement type check \n";
	let cfg = [("model", "true"); ("proof", "false")] in
	let ctx = (mk_context cfg) in
      	let pi = (Expr.mk_const ctx (Symbol.mk_string ctx "pi") (Real.mk_sort ctx)) in
	let y0 = (Expr.mk_const ctx (Symbol.mk_string ctx "y0") (Real.mk_sort ctx)) in
	let constraints = 
	Boolean.mk_not ctx (Boolean.mk_implies ctx  (Boolean.mk_and ctx [
		Boolean.mk_eq ctx pi (Real.mk_numeral_s ctx "3.14159");
		Boolean.mk_eq ctx y0 (Real.mk_numeral_s ctx "2.0");
	]) (Arithmetic.mk_ge ctx y0 (Real.mk_numeral_s ctx "1.0"))) in
	Printf.printf "%s\n"( Expr.to_string constraints);
	let solver = (mk_solver ctx None) in
	let s = (Solver.add solver [constraints]) in
	let q = check solver [] in
	Printf.printf "Solver says: %s\n" (string_of_status q) ;
    	if q == SATISFIABLE then
      		(Printf.printf "Type checked\n";
      		let m = (get_model solver) in    
      		match m with 
      		| None -> Printf.printf "None"
		| Some (m) -> 
	  	Printf.printf "Model: \n%s\n" (Model.to_string m))
    	else
    		let m = (get_model solver) in    
      		match m with 
		| None -> raise (TestFailedException "")
		| Some (m) -> 
	  	Printf.printf "Model: \n%s\n" (Model.to_string m)
	);
    Printf.printf "Exiting.\n" ;
    exit 0
  ) with Error(msg) -> (
    Printf.printf "Z3 EXCEPTION: %s\n" msg ;
    exit 1
  )    
;;
