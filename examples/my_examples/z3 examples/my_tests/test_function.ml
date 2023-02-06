(*Test function*)

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
      	Printf.printf "Running Z3 function application check \n";
	let cfg = [("model", "true"); ("proof", "false")] in
	let ctx = (mk_context cfg) in
	let x = (Expr.mk_const ctx (Symbol.mk_string ctx "x") (Real.mk_sort ctx)) in
	let y = (Expr.mk_const ctx (Symbol.mk_string ctx "y") (Real.mk_sort ctx)) in
	let fname = mk_string ctx "f" in
	let bs = Real.mk_sort ctx in
	let domain = [bs] in
	let f = FuncDecl.mk_func_decl ctx fname domain bs in
	let fapp = mk_app ctx f [x] in
	let types = [bs;bs] in
	let names = [(Symbol.mk_string ctx "x");
	             (Symbol.mk_string ctx "y")] in
	(* x >= 1 -> y < 0 *)
	let quantification = (Boolean.mk_implies ctx (Arithmetic.mk_ge ctx x (Real.mk_numeral_s ctx "1.0")) (Arithmetic.mk_lt ctx y (Real.mk_numeral_s ctx "0.0"))) in
	(* y > 0 AND y < 0 *)
	let quantification = (Boolean.mk_and ctx [(Arithmetic.mk_lt ctx y (Real.mk_numeral_s ctx "0.0")); (Arithmetic.mk_gt ctx y (Real.mk_numeral_s ctx "0.0"))]) in
	(* forall x y , (x >= 1 -> y < 0) *)
	let quantify = (Quantifier.mk_forall ctx types names quantification (Some 1) [] [] (Some (Symbol.mk_string ctx "Q")) (Some (Symbol.mk_string ctx "skid"))) in
	let constraints = Boolean.mk_and ctx 
				(* f(x) = x*x , f(x) = y , x >= 1.0 *)
				[ (*(Boolean.mk_eq ctx fapp (Arithmetic.mk_mul ctx [x; x]));
				  (Boolean.mk_eq ctx fapp y);
				  (Arithmetic.mk_ge ctx x (Real.mk_numeral_s ctx "1.0"));*)
				  Quantifier.expr_of_quantifier quantify
				  (*quantification*)
				] in
	print_string (Expr.to_string (constraints));
	print_newline();
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
