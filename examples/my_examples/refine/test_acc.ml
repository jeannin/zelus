(* The Zelus compiler, version 2.2-stable
  (2022-06-25-19:51) *)
open Ztypes
type ('b , 'a) _exec =
  { mutable i_37 : 'b ; mutable m_33 : 'a }

let exec  = 
  
  let exec_alloc _ =
    ();
    { i_37 = (false:bool) ; m_33 = ((42. , 42. , 42.):float * float * float) } in
  let exec_reset self  =
    ((self.i_37 <- true ; self.m_33 <- (0. , 1. , 0.)):unit) in 
  let exec_step self () =
    (((if self.i_37 then self.m_33 <- (0. , 1. , 0.)) ;
      self.i_37 <- false ;
      (let ((x_34:float) , (x_35:float) , (x_36:float)) = self.m_33 in
       let (((xf_32:float) , (vf_31:float) , (af_30:float)): (float  *
                                                              float  * float)) =
           (x_34 , x_35 , x_36) in
       self.m_33 <- (((+.) xf_32  (( *. ) vf_31  0.01)) ,
                     ((+.) vf_31  (( *. ) af_30  0.01)) ,
                     (if (>=) ((+.) ((+.) xf_32 
                                          ((/.) (( ** ) vf_31  2.) 
                                                (( *. ) 2.  1.))) 
                                    (( *. ) vf_31  0.01))  5.
                      then 1.
                      else 0.)) ; (xf_32 , vf_31 , af_30))):float *
                                                            float * float) in
  Node { alloc = exec_alloc; reset = exec_reset ; step = exec_step }
