open Printf
open Digraph
open Fst

let main () =
  printf "test-fst\n";
  let (d : transition_graph) = Digraph.make () in
    add d (0,1) ("a","c");
    add d (1,2) ("b","b");
    add d (2,2) ("b","e");
    add d (2,4) ("c","a");
    add d (2,3) ("a","c");
    let t1 = {d = d; q0=0  ; qf=[3;4] } in
    printf "t1 a = %s\n" (run t1 "a");
    printf "t1 ab = %s\n" (run t1 "ab");
    printf "t1 abbbc = %s\n" (run t1 "abbbc");
  exit 0;;

main();

