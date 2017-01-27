(*
**
** ocaml module implementation Soundex
**
** Description: Soundex algorithm for phonetic indexing
** using finite state transducers
**
** Author: Eray Ozkural (exa) <erayo@cs.bilkent.edu.tr>, (C) 2003
**
** Copyright: See COPYING file that comes with this distribution
**
*)

open Printf
open Digraph
open Fst

let compose f g = function x -> f(g(x))

let uppercase = ["A";"B";"C";"D";"E";"F";"G";"H";"I";"J";
		 "K";"L";"M";"N";"O";"P";"Q";"R";"S";"T";"U";
		 "V";"W";"X";"Y";"Z"]

let lowercase = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j";"k";
		 "l";"m";"n";"o";"p";"q";"r";"s";"t";"u";
		 "v";"w";"x";"y";"z"]

let digits = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9']

let digits_str = List.map (String.make 1) digits

(* keep the first letter and drop all occurences of a list of
   non-initial letters *)
let fsta =
  let keep = ["b";"c";"d";"f";"g";"j";
	      "k";"l";"m";"n";"p";"q";"r";"s";"t";"v";"x";"z"] in
  let drop = ["a";"e";"h";"i";"o";"u";"w";"y"] in
  let (d : transition_graph) = Digraph.make () in
    List.iter (fun x -> add d (0,1) (x,x)) uppercase;
    List.iter (fun x ->
		 add d (1,2) (x,x);
		 add d (2,2) (x,x)
	      ) keep;
    List.iter (fun x ->
		 add d (1,2) (x,"");
		 add d (2,2) (x,"")
	      ) drop;
    {d=d; q0=0; qf=[0;1;2]}
    
(* replace the remaining letters with numbers *)
let fstb =
  let (d : transition_graph) = Digraph.make () in
    List.iter (fun x -> add d (0,1) (x,x)) uppercase;
    List.iter (fun x -> add d (1,1) (x,"1")) ["b";"f";"p";"v"];
    List.iter (fun x -> add d (1,1) (x,"2")) ["c";"g";"j";"k";"q";
					      "s";"x";"z"];
    List.iter (fun x -> add d (1,1) (x,"3")) ["d";"t"];
    add d (1,1) ("l","4");
    List.iter (fun x -> add d (1,1) (x,"5")) ["m";"n"];
    add d (1,1) ("r","6");
    {d=d; q0=0; qf=[0;1]}

(* replace any sequence of identical numbers with a single number *)
(* assume sentinel character # in input here *)
let fstc =
  let digitsa = Array.of_list digits_str in
  let (d : transition_graph) = Digraph.make () in
    List.iter (fun x -> add d (0,1) (x,x)) uppercase; (* skip first *)
    Array.iteri (fun i x ->
		   add d (1,10+i) (x, ""); (* eat identical numbers *)
		   add d (10+i,10+i) (x, "");
		   add d (1,2) ("#", "");
		   Array.iteri (fun j y ->
				  if (x<>y) then
				    add d (10+i,10+j) (y,x);
				  add d (10+i,2) ("#",x);
			       ) digitsa;
		) digitsa;
    {d=d; q0=0; qf=[2]}

(* convert to form Letter Digit Digit Digit *)
(* assume sentinel character # in input here *)
let fstd =
  let (d : transition_graph) = Digraph.make () in
    List.iter (fun x -> add d (0,1) (x,x)) uppercase;
    List.iter (fun x -> add d (1,2) (x,x)) digits_str;
    List.iter (fun x -> add d (2,3) (x,x)) digits_str;
    List.iter (fun x -> add d (3,4) (x,x)) digits_str;
    add d (1,4) ("#","000");
    add d (2,4) ("#","00");
    add d (3,4) ("#","0");
    {d=d; q0=0; qf=[4;5]}

let soundex =
  compose (run fstd)
    (compose (run fstc) (compose (run fstb) (run fsta)  ))
(*  List.fold_right compose (List.map run [fsta; fstb; fstc; fstd]) *)

let trace_soundex x =
  let a = run fsta x in
  let b = run fstb a in
  let c = run fstc b in
  let d = run fstd c in
    printf "a=%s, b=%s, c=%s, d=%s\n" a b c d
