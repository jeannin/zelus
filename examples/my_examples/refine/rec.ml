(* The Zelus compiler, version 2.2-stable
  (2022-04-14-3:0) *)
open Ztypes
type ('e , 'd , 'c , 'b , 'a) _min_max =
  { mutable i_39 : 'e ;
    mutable m_35 : 'd ;
    mutable m_33 : 'c ; mutable m_29 : 'b ; mutable m_27 : 'a }

let min_max  = 
  
  let min_max_alloc _ =
    ();
    { i_39 = (false:bool) ;
      m_35 = (Obj.magic ():'a) ;
      m_33 = (Obj.magic ():'a) ;
      m_29 = (Obj.magic ():'a) ; m_27 = (Obj.magic ():'a) } in
  let min_max_reset self  =
    (self.i_39 <- true:unit) in 
  let min_max_step self (x_24:'a105) =
    ((let (x_38:'a105) =
          if self.i_39
          then x_24
          else if (>) x_24  self.m_33 then x_24 else self.m_35 in
      let (x_32:'a105) =
          if self.i_39
          then x_24
          else if (<) x_24  self.m_27 then x_24 else self.m_29 in
      self.i_39 <- false ;
      self.m_35 <- x_38 ;
      self.m_33 <- x_38 ;
      self.m_29 <- x_32 ; self.m_27 <- x_32 ; (x_32 , x_38)):'a * 'a) in
  Node { alloc = min_max_alloc; reset = min_max_reset ; step = min_max_step }
