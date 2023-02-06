(* The Zelus compiler, version 2.2-stable
  (2022-04-14-3:0) *)
open Ztypes
type _main = unit

let main  = 
   let main_alloc _ = () in
  let main_reset self  =
    ((()):unit) in 
  let main_step self () =
    ((let ((y_9:int): int) = 3 in
      let (z_10:int) = (+) 4  y_9 in
      print_int z_10):unit) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
