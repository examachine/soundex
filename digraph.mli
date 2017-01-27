(*
**
** ocaml module interface Digraph
**
** Description: Directed graph ADT
** implementing adjacency list representation
** hacked to support labels
**
** Author: Eray Ozkural (exa) <erayo@cs.bilkent.edu.tr>, (C) 2003
**
** Copyright: See COPYING file that comes with this distribution
**
*)

type edge = int * int
(* an edge is an ordered pair of a source and target vertex *)

type 'a digraph

(*type 'a t = 'a digraph*)

val make : unit -> 'a digraph

(* adjacency of a vertex *)

val adj : 'a digraph -> int -> (int * 'a) list
(* adjacency of a vertex *)

val set_adj : 'a digraph -> int -> (int * 'a) list -> unit
(* set adjacency of a vertex *)

val degree : 'a digraph -> int -> int
(* query degree of a vertex *)

val add : 'a digraph -> edge -> 'a -> unit
(* add edge with given label *)

(*val remove : 'a digraph -> edge -> unit*)
(* remove an edge *)

val edge_in : 'a digraph -> edge -> bool
(* query edge *)

val label : 'a digraph -> edge -> 'a
(* query label *)

val find_edge : 'a digraph -> int -> ('a -> bool) -> (int * 'a)
(*val set_label : digraph -> int -> int -> 'a -> unit *)

val vertex_in : 'a digraph -> int -> bool
(* query vertex *)

val num_edges : 'a digraph -> int
(* query number of edges *)

val num_vertices : 'a digraph -> int
(* query number of vertices *)

val to_string : 'a digraph -> ('a -> string) -> string

val dot_graph : 'a digraph -> string
(* graphviz representation of the graph *)

