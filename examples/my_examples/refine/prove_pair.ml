and prove_pair ctx env e_list tuple_type e typenv =
(*
    ctx      -> z3 context
    env      -> local scope environment
    e_list   -> list containing  tuple elements
    txp_list -> list containing tuple base types and binding variables  , i.e  x:int
    e        -> expression for tuple refinement type 
    typenv   -> local scope type environment

    Apply pair typing rule to tuple elements

    Gamma |- e1 : t1         Gamma |- e2 : [e1/x] t2
  ---------------------------------------------------- (DEPENDENT PAIR)
         Gamma |- (e1, e2) : Sigma(x : t1).t2

*)
  match e_list with
  (* | h :: t -> ( 
    (*
       h = 5
       t = (5 + 3, 5 + 4)

       (x = 5) && env

      x:int
    *)
    match (List.hd txp_list).desc with 
      | Erefinementpair(n, _ ) -> Printf.printf "Prove pair call - variable: %s\n" n; 
                                  e := Boolean.mk_and ctx [
                                          (Boolean.mk_eq ctx (create_z3_var ctx env n) (expression ctx env h typenv));
                                          !e ] ;
                                  Printf.printf "Success substitution: %s\n" (Expr.to_string !e);
                                  let txp_tl = List.tl txp_list in
                                   prove_pair ctx env t txp_tl e typenv
      | _ -> Printf.printf "Undefined type for pair element"
  ) *)
    | h :: [] -> ( 
      Printf.printf "Last element\n";
      match tuple_type.desc with 
        | Erefinementpair(n,typ) -> 
            (match typ.desc with 
              | Etypevar(basetype) -> Printf.printf "Etypevar\n";
              | Etypeconstr(basetype, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n"; 
                            (
                              match basetype with 
                              | Name(btype) -> Printf.printf "Basetype found %s\n" btype; Printf.printf "Prove pair call - variable: %s\n" n;
                                    let last_element = Boolean.mk_eq ctx (create_z3_var ctx env n) 
                                    (expression ctx env h typenv) in
                                    z3_solve ctx (ref ({exp_env = ref [last_element] ; var_env = Hashtbl.create 0})) !e
                              | Modname(q) -> Printf.printf "Modname found %s\n" q.id
                            ) 
                      | Etypetuple(typ_exp_list) ->  Printf.printf "Etypetuple pairs\n"
                      | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec pairs\n"
                      | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun pairs\n"
                      | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement pairs\n"
                      | Erefinement(ty_exp, e) -> Printf.printf "Erefinement pairs\n"
                      | _ -> Printf.printf "Modname undefined pairs\n"
              | Etypetuple(tuple_type) ->  Printf.printf "Etypetuple\n"
              | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec\n"
              | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun\n"
              | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement\n"
              | Erefinement(ty_exp, e) -> Printf.printf "Erefinement\n"
              | _ -> Printf.printf "Undefined modname\n"
            )
        | Etypetuple(tuple_type) -> Printf.printf "Etypetuple list\n";
            (match (List.hd tuple_type).desc with 
                  | Etypevar(basetype) -> Printf.printf "Etypevar\n";
                  | Etypeconstr(basetype, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n"; 
                                (
                                  match basetype with 
                                  | Name(btype) -> Printf.printf "Basetype found %s\n" btype; Printf.printf "Prove pair call - variable: \n";
                                  | Modname(q) -> Printf.printf "Modname found %s\n" q.id
                                ) 
                          | Etypetuple(typ_exp_list) ->  Printf.printf "Etypetuple pairs\n"
                          | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec pairs\n"
                          | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun pairs\n"
                          | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement pairs\n"
                          | Erefinement(ty_exp, e) -> Printf.printf "Erefinement pairs\n"
                          | _ -> Printf.printf "Modname undefined pairs\n"
                  | Etypetuple(tuple_type) ->  Printf.printf "Etypetuple\n"
                  | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec\n"
                  | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun\n"
                  | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement\n"
                  | Erefinement(ty_exp, e) -> Printf.printf "Erefinement\n"
                  | _ -> Printf.printf "Undefined modname\n"
                )
        | _ -> Printf.printf "Undefined type for last element of pair"
    )
    | h :: t -> ( 
      match tuple_type.desc with 
        | Erefinementpair(n, typ) ->
           (match typ.desc with
           | Etypevar(basetype) -> (Printf.printf "Prove pair call - variable: %s\n" n; 
                                    e := Expr.substitute_one !e (create_z3_var_typed ctx env n basetype)
                                                                (expression ctx env h typenv);
                                                           Printf.printf "Success substitution\n"; 
                                    (* e := [
                                            (Boolean.mk_eq ctx (create_z3_var ctx env n) (expression ctx env h typenv));
                                            !e ] ; *)
                                    Printf.printf "Success substitution: %s\n" (Expr.to_string !e);
                                    (*let txp_tl = List.tl txp_list in
                                    prove_pair ctx env t txp_tl e typenv*))
           | Etypeconstr(basetype, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n"; 
                (
                  match basetype with 
                  | Name(btype) -> Printf.printf "Basetype found %s\n" btype; (Printf.printf "Prove pair call - variable: %s\n" n;
                                    e := Boolean.mk_implies ctx 
                                            (Boolean.mk_eq ctx (create_z3_var ctx env n) (expression ctx env h typenv))  (!e);
                                  (* e := Expr.substitute_one !e (create_z3_var ctx env n)
                                                              (expression ctx env h typenv); *)
                                                        Printf.printf "Success substitution: %s\n" (Expr.to_string !e);
                                                        (*let txp_tl = List.tl txp_list in
                                                        prove_pair ctx env t txp_tl e typenv*))
                  | Modname(q) -> Printf.printf "Modname found %s\n" q.id
                ) 
           | Etypetuple(tuple_type) ->  Printf.printf "Etypetuple pairs\n";
              (match (List.hd tuple_type).desc with 
                  | Etypevar(basetype) -> Printf.printf "Etypevar\n";
                  | Etypeconstr(basetype, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n"; 
                                (
                                  match basetype with 
                                  | Name(btype) -> Printf.printf "Basetype found %s\n" btype; Printf.printf "Prove pair call - variable: \n";
                                  | Modname(q) -> Printf.printf "Modname found %s\n" q.id
                                ) 
                          | Etypetuple(typ_exp_list) ->  Printf.printf "Etypetuple pairs\n"
                          | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec pairs\n"
                          | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun pairs\n"
                          | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement pairs\n"
                          | Erefinement(ty_exp, e) -> Printf.printf "Erefinement pairs\n"
                          | _ -> Printf.printf "Modname undefined pairs\n"
                  | Etypetuple(tuple_type) ->  Printf.printf "Etypetuple\n"
                  | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec\n"
                  | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun\n"
                  | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement\n"
                  | Erefinement(ty_exp, e) -> Printf.printf "Erefinement\n"
                  | _ -> Printf.printf "Undefined modname\n"
                )
           | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec pairs\n"
           | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun pairs\n"
           | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement pairs\n"
           | Erefinement(ty_exp, e) -> Printf.printf "Erefinement pairs\n"
           | _ -> Printf.printf "Modname undefined pairs\n")
        | Etypeconstr(typ, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n" 
        | Etypevar(n) -> Printf.printf "Etypevar : %s\n" n
        | Etypetuple(tuple_type) ->  Printf.printf "Etypetuple list\n";
                (match (List.hd tuple_type).desc with 
                | Erefinementpair(n, typ) ->
                  (match typ.desc with
                  | Etypevar(basetype) -> (Printf.printf "Prove pair call - variable: %s\n" n; 
                                           e := Expr.substitute_one !e (create_z3_var_typed ctx env n basetype)
                                                                       (expression ctx env h typenv);
                                                                  Printf.printf "Success substitution\n"; 
                                           (* e := [
                                                   (Boolean.mk_eq ctx (create_z3_var ctx env n) (expression ctx env h typenv));
                                                   !e ] ; *)
                                           Printf.printf "Success substitution: %s\n" (Expr.to_string !e);
                                           let txp_tl = List.tl tuple_type in
                                           prove_pair ctx env t {desc: txp_tl; loc: Zlocation.no_location } e typenv)
                  | Etypeconstr(basetype, typ_exp_list) -> Printf.printf "Etypeconstr pairs\n"; 
                       (
                         match basetype with 
                         | Name(btype) -> Printf.printf "Basetype found %s\n" btype; (Printf.printf "Prove pair call - variable: %s\n" n;
                                           e := Boolean.mk_implies ctx 
                                                   (Boolean.mk_eq ctx (create_z3_var ctx env n) (expression ctx env h typenv))  (!e);
                                         (* e := Expr.substitute_one !e (create_z3_var ctx env n)
                                                                     (expression ctx env h typenv); *)
                                                               Printf.printf "Success substitution: %s\n" (Expr.to_string !e);
                                                               let txp_tl = List.tl txp_list in
                                                               prove_pair ctx env t {desc: txp_tl; loc: Zlocation.no_location } e typenv)
                         | Modname(q) -> Printf.printf "Modname found %s\n" q.id
                       ) 
                  )
                | _ -> Printf.printf "Undefined modname\n"
              )
        | Etypevec(typ_exp, sz) -> Printf.printf "Etypevec\n"
        | Etypefun(k, t, typ_exp1, typ_exp2) -> Printf.printf "Etypefun\n"
        | Etypefunrefinement(k, t, typ_exp1, typ_exp2, e) -> Printf.printf "Etypefunrefinement\n"
        | Erefinement(ty_exp, e) -> Printf.printf "Erefinement\n"
        | _ -> Printf.printf "Undefined type for pair element"
    )
