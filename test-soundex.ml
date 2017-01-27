open Printf
open Digraph
open Fst
open Soundex

let main () =
  printf "test-soundex\n";
  printf "soundex Jack = %s\n" (soundex "Jack");
  printf "soundex Mary = %s\n" (soundex "Mary");
  printf "soundex Ilyas = %s\n" (soundex "Ilyas");
  printf "soundex Dennis = %s\n" (soundex "Dennis");
  printf "soundex Georgiopoulus = %s\n" (soundex "Georgiopoulus");

  exit 0;;

main();

