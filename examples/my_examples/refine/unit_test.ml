(* The Zelus compiler, version 2.2-stable
  (2022-05-16-15:13) *)
open Ztypes
let pi = 3.14159

let w = ( *. ) 2.  pi

let y0 = 4.

let y1 = 10.

let f2 ((x_32:int): int) =
  let (y_33:int) = ( * ) x_32  x_32 in
  y_33

let f3 ((x_34:int): int) =
  ( * ) x_34  x_34

type _main = unit

let main  = 
   let main_alloc _ = () in
  let main_reset self  =
    ((()):unit) in 
  let main_step self () =
    ((let ((y_37:int): int) = 3 in
      let (z_38:int) = (+) 4  y_37 in
      let _ = print_int z_38 in
      let ((y_35:int): int) = 0 in
      let (z_36:int) = (+) (-1)  y_35 in
      z_36):int) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
