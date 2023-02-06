(* The Zelus compiler, version 2.2-stable
  (2022-04-14-3:0) *)
open Ztypes
type ('b , 'a) _main =
  { mutable i_48 : 'b ; mutable m_45 : 'a }

let main  = 
  
  let main_alloc _ =
    ();{ i_48 = (false:bool) ; m_45 = ((42. , 42.):float * float) } in
  let main_reset self  =
    ((self.i_48 <- true ; self.m_45 <- (0.5 , 15.)):unit) in 
  let main_step self () =
    (((if self.i_48 then self.m_45 <- (0.5 , 15.)) ;
      self.i_48 <- false ;
      (let ((x_46:float) , (x_47:float)) = self.m_45 in
       self.m_45 <- ((if (<=) x_47  16. then 0.5 else 0.) ,
                     ((+.) x_47  (( *. ) 0.1  ((-.) x_46  0.1)))) ;
       (x_46 , x_47))):float * float) in
  Node { alloc = main_alloc; reset = main_reset ; step = main_step }
