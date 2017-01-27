open Printf
open Scanf
open Digraph
open Fst
open Soundex

let main () =
  printf "soundex-cli\n";
  printf "Please enter string: %!";
  let s = scanf "%s" (fun x->x) in
    printf "Soundex coding: %s \n" (soundex s);
    exit 0;;

main();

