(* The Zelus compiler, version 2.2-stable
  (2022-06-25-19:51) *)
open Ztypes
type ('a) _main =
  { mutable m_12 : 'a }

let main  = 
   let main_alloc _ =
     ();{ m_12 = ((42 , 42):int * int) } in
  let main_reset self  =
    (self.m_12 <- (0 , 0):unit) in 
  let main_step self () =
    ((let ((x_13:int) , (x_14:int)) = self.m_12 in
      let (((x_10:int) , (y_11:int)): (int  * int)) = (x_13 , x_14) in
      self.m_12 <- ((if (>) x_10  5 then 0 else (+) x_10  1) ,
                    (( * ) 2  x_10)) ; (x_10 , y_11)):int * int) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
