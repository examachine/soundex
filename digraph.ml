(*
**
** ocaml module implementation Digraph
**
** Description: Directed graph ADT
** implementing adjacency list representation
** hacked for labels and multi-graph
**
** Author: Eray Ozkural (exa) <erayo@cs.bilkent.edu.tr>, (C) 2003
**
** Copyright: See COPYING file that comes with this distribution
**
*)

open Printf

type edge = int * int
(* an edge is an ordered pair of vertices *)

type 'a digraph = {
  adj : ( (int * 'a) list) Dynarray.dynarray;
}
(* adjacency list representation for directed graph 
 * to provide for labels we store an association list of
 * target vertices and labels
 *)

let make () = {
  adj = Dynarray.make [];
}

(* get neighborhood of vertex u *)

let n g u = Dynarray.get g.adj u

let adj g u = n g u

let set_adj g u a = Dynarray.set g.adj u a

let degree g u = List.length (n g u)


let add g (u,v) l =
  let n = n g u in
    Dynarray.set g.adj u ((v,l) :: n)
      
(*
let remove g (u,v) =
  let n = n g u in
    Dynarray.set g.adj u (List.remove_assoc v n)
*)

(* is any edge (u,v) \in g ? *)
let edge_in g (u,v) =
  let n = n g u in
    List.mem_assoc v n

(* retrieve the label of any (u,v) \in g *)
let label g (u,v) =
  let n = n g u in
    List.assoc v n

(* this is crucial, search for an edge with given property *)
let find_edge g u f =
  let n = n g u in
    List.find (fun (v,l)->f l) n
  
(*let vertex_in g u = u < Dynarray.length g.adj*)

let vertex_in g u = degree g u > 0

let num_edges g =
  Array.fold_left (+) 0 (Dynarray.mapa (function x -> List.length x) g.adj)

let num_vertices g = Dynarray.length g.adj

let list_to_string el lst = "[" ^ String.concat ";" (List.map el lst)
			    ^  "]"

let edges_to_string el lst = String.concat "," (List.map el lst)

let to_string g sl =
  let prne i (u,l) = "(" ^ string_of_int i ^ "," ^
		     string_of_int u ^ ":" ^ (sl l) ^ ")" in
    "{" ^ String.concat ","
    (Array.to_list (Dynarray.mapai (fun i x -> list_to_string (prne i)
				      x) g.adj))
    ^ "}"

let dot_graph g = "TODO: dot graph here"
