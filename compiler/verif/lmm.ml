(**************************************************************************)
(*                                                                        *)
(*  The Zelus Hybrid Synchronous Language                                 *)
(*  Copyright (C) 2012-2015                                               *)
(*                                                                        *)
(*  Timothy Bourke                                                        *)
(*  Marc Pouzet                                                           *)
(*                                                                        *)
(*  Universite Pierre et Marie Curie - Ecole normale superieure - INRIA   *)
(*                                                                        *)
(*   This file is distributed under the terms of the CeCILL-C licence     *)
(*                                                                        *)
(**************************************************************************)
(* Abstract syntax tree for a Lustre flat kernel *)

open Location
open Ident
open Deftypes

type 'a localized = { desc: 'a; loc: Location.location }

type kind = A | D

type exp =
  | Elocal of Ident.t
  | Eglobal of Lident.t
  | Econst of immediate
  | Econstr0 of Lident.t
  | Eapp of op * exp list
  | Erecord_access of exp * Lident.t
  | Erecord of (Lident.t * exp) list
  | Etuple of exp list
		  
 and op =
   | Eunarypre | Eminusgreater | Eifthenelse | Esharp | Eop of Lident.t
							
 and immediate = Deftypes.immediate
		   
 and pattern =
   | Etuplepat of pattern list
   | Evarpat of Ident.t
		  
 and eq =
   { eq_lhs: pattern;
     eq_rhs: exp;
     eq_loc: location }
     
 and funexp =
   { f_kind: kind;
     f_inputs: vardec list;
     f_outputs: vardec list;
     f_local: vardec list;
     f_body: eq list;
     f_assert: exp list }

 and vardec =
   { p_kind: pkind;
     p_name: Ident.t;
     p_typ: Deftypes.typ;
     p_loc: location }
     
 and pkind = | Estatic | Evar 
			   
 and implementation = implementation_desc localized
					  
 and implementation_desc =
   | Econstdecl of name * exp
   | Efundecl of name * funexp
   | Etypedecl of name * name list * Zelus.type_decl
