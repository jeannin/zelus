(* The Zelus compiler, version 2024-dev
  (2024-12-6-14:11) *)
open Ztypes
type ('b, 'a) machine_35 = {mutable i_34: 'b; mutable m_29: 'a}
type ('c, 'b, 'a) machine_33 =
{mutable m_24: 'c; mutable m_32: 'b; mutable m_25: 'a}
let m = let machine_33  = 
          
          let machine_33_alloc _ =
            ();{ m_24 = (42:int); m_32 = (42:int); m_25 = (42:int) } in
          let machine_33_reset self  =
            ((self.m_32 <- 0):unit) in
          let machine_33_step self ((m_24:Stdlib.int)) =
            ((self.m_25 <- self.m_32;
              self.m_32 <- Stdlib.(+) self.m_24 self.m_32; self.m_32):
            int) in
          Node { alloc = machine_33_alloc; reset = machine_33_reset;
                                           step = machine_33_step } in
          machine_33

let m = Test1.r_11
let m = 42
let m = let machine_35  = 
          let Node { alloc = i_34_alloc; step = i_34_step; reset = i_34_reset } = Test1.add 
           in
          let machine_35_alloc _ =
            ();{ m_29 = (42:int);i_34 = i_34_alloc () (* discrete *)  } in
          let machine_35_reset self  =
            (i_34_reset self.i_34 :unit) in
          let machine_35_step self _ =
            ((self.m_29 <- i_34_step self.i_34 1;
              (let _ = Stdlib.print_int self.m_29 in
               Stdlib.print_newline ())):unit) in
          Node { alloc = machine_35_alloc; reset = machine_35_reset;
                                           step = machine_35_step } in
          machine_35

let m = Test1.r_13
