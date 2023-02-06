(* The Zelus compiler, version 2.1-dev
  (2021-05-19-23:17) *)
open Ztypes
let f ((a_6:int): int) =
  a_6

type _main = unit

let main  = 
   let main_alloc _ = () in
  let main_reset self  =
    ((()):unit) in 
  let main_step self () =
    ((let ((a_7:int): int) = 2 in
      a_7):int) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
