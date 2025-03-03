open Ident
open Global
open Modules
open Zelus
open Ptypes

let expression e ff =
   let expr_type = Typinfo.get_type e.e_info in 
    output_type ff expr_type

let equation ff {eq_desc; eq_loc} =
    match eq_desc with
    | EQeq(p, e) -> Printf.printf "RHS of equation has type: "; expression e ff
    | _ -> Printf.printf "Unknown equation type\n"

let leq ff ({ l_kind; l_eq; l_loc } as l) =
        equation ff l_eq

let implementation ff impl = 
   match impl.desc with
   | Eletdecl { d_names; d_leq } ->
      Printf.printf "Let decl\n";
      leq ff d_leq;
      impl
   | _ -> Printf.printf "Not sure what to do\n";
      impl

let program ff ({ p_impl_list } as p) = 
        Printf.printf "Found %d clauses\n" (List.length p_impl_list);
        let p_impl_list = Util.iter (implementation ff) p_impl_list in
        {p with p_impl_list}
