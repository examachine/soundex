(*
**
** ocaml module Fst
**
** Description: Finite State Transducer (FST) implementation
**
** Author: Eray Ozkural (exa) <erayo@cs.bilkent.edu.tr>, (C) 2003
**
** Copyright: See COPYING file that comes with this distribution
**
*)

open Printf

type transition_graph = (string * string) Digraph.digraph

type fst = {
  d: transition_graph;			(* fst transition function *)
  q0: int; 				(* initial state *)
  qf: int list;				(* list of final states *)
}
	
let matchprefix str pfx =
  if String.length str >= String.length pfx then
    String.sub str 0 (String.length pfx) = pfx
  else
    false

let matchinfix str p ifx =
  if String.length str >= p + (String.length ifx) then
    String.sub str p (String.length ifx) = ifx
  else
    false

(* run fst over input string x, starting from state*)
let rec runaux fst x state =
  let finalstate = List.exists ((=) state) fst.qf in
    try
      let (nextstate,(input,output)) =
	Digraph.find_edge fst.d state (fun (i,o) -> matchprefix x i) in
      let nx = String.length x
      and ni = String.length input in
(*	printf "q%d, x:%s, %s->%s\n" state x input output;*)
	output::runaux fst (String.sub x ni (nx-ni)) nextstate
    with Not_found ->
      (*printf "OMG!\n";*)
      []

let run fst x = String.concat "" (runaux fst (x^"#") fst.q0)

(*let runsentinel fst x = run fst (x^"#")*)


