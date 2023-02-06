(* The Zelus compiler, version 2.2-stable
  (2022-06-25-19:51) *)
open Ztypes
type ('a) _sim =
  { mutable m_12 : 'a }

let sim  = 
   let sim_alloc _ =
     ();{ m_12 = ((42. , 42.):float * float) } in
  let sim_reset self  =
    (self.m_12 <- (0. , 15.):unit) in 
  let sim_step self () =
    ((let ((x_13:float) , (x_14:float)) = self.m_12 in
      let (((power_10:float) , (temp_11:float)): (float  * float)) =
          (x_13 , x_14) in
      self.m_12 <- ((if (<=) temp_11  16. then 0.05 else 0.) ,
                    ((+.) temp_11  ((-.) power_10  0.01))) ;
      (power_10 , temp_11)):float * float) in
  Node { alloc = sim_alloc; reset = sim_reset ; step = sim_step }
