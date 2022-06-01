(* The Zelus compiler, version 2.2-stable
  (2022-05-25-15:25) *)
open Ztypes
type nat = { v : int }
type _main = unit

let main  = 
   let main_alloc _ = () in
  let main_reset self  =
    ((()):unit) in 
  let main_step self () =
    (print_string "hello world":unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
