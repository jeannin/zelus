(* The Zelus compiler, version 2.2-dev
  (2023-02-13-6:34) *)
open Ztypes
type ('a) _sim =
  { mutable m_12 : 'a }

let sim  = 
   let sim_alloc _ =
     ();{ m_12 = ((42 , 42):int * int) } in
  let sim_reset self  =
    (self.m_12 <- (1 , 1):unit) in 
  let sim_step self () =
    ((let ((x_13:int) , (x_14:int)) = self.m_12 in
      let (((x_10:int) , (y_11:int)): (int  * int)) = (x_13 , x_14) in
      self.m_12 <- (((~-) x_10) , (if (<) x_10  0 then (~-) x_10 else x_10))
      ; (x_10 , y_11)):int * int) in
  Node { alloc = sim_alloc; reset = sim_reset ; step = sim_step }
