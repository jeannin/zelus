(* The Zelus compiler, version 2.2-stable
  (2022-06-25-19:51) *)
open Ztypes
type _main = unit

let main  = 
   let main_alloc _ = () in
  let main_reset self  =
    ((()):unit) in  let main_step self () =
                      (():unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
