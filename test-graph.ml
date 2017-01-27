type graph = float Digraph.digraph

let g : graph = Digraph.make ()

let main () =
  print_string "test-graph\n";
  Digraph.add g (1,3) 5.3;
  Digraph.add g (0,2) 2.5;
  Digraph.add g (0,1) 1.5;
  Printf.printf "E=%s \n" (Digraph.to_string g string_of_float);
  Digraph.add g (2,4) 0.9;
  Digraph.add g (0,4) 0.2;
  Digraph.add g (2,6) 1.8;
  Digraph.add g (4,0) 4.1;
  Digraph.add g (6,5) 0.5;
  Digraph.add g (5,4) (-1.7);
  Digraph.add g (5,1) 2.6;
  Digraph.add g (3,5) 8.4;
  Printf.printf "E=%s \n" (Digraph.to_string g string_of_float);
  Printf.printf "number of vertices %d \n" (Digraph.num_vertices g);
  Printf.printf "number of edges %d \n" (Digraph.num_edges g);
  Printf.printf "is (2,6) in? %b \n" (Digraph.edge_in g (2,6));
  (*Digraph.remove g (2,6);
  Digraph.remove g (4,0);
  Digraph.remove g (5,0);*) (*no such edge*)
  Printf.printf "E=%s \n" (Digraph.to_string g string_of_float);
  Printf.printf "is (2,6) in? %b \n" (Digraph.edge_in g (2,6));
  Printf.printf "number of vertices %d \n" (Digraph.num_vertices g);
  Printf.printf "number of edges %d \n" (Digraph.num_edges g);
  Printf.printf "label of (5,4)=%f \n" (Digraph.label g (5,4));
  exit 0;;

main();
