
(* check if the *value* of assoc exists *)
let rec mem_assoc x y = function
  | [] -> false
  | (a, b) :: l -> (a = x && b = y) || mem_assoc x l

(* remove all associations with a given value*)
let rec remove_assoc x y = function
  | [] -> []
  | (a, b as pair) :: l -> if a = x then l else pair :: remove_assoc x l
