(* 逆ポーランド記法電卓 (関数型スタイル) *)

#load "str.cma"

module RPNCalculator : sig
  val calculate : string -> float
end = struct
  let ope_fn = function
    | "+" -> ( +. )
    | "-" -> ( -. )
    | "*" -> ( *. )
    | "/" -> ( /. )
    | ope -> failwith ("unsupported operator '" ^ ope ^ "' is used")

  let calculate rpn =
    let rec calc stack = function
    | [] -> List.hd stack
    | x :: xs when Str.string_match (Str.regexp "^[+-]?[0-9]+$") x 0
      -> calc ((float_of_string x) :: stack) xs
    | x :: xs -> match stack with
      | y1 :: y2 :: ys -> calc (ope_fn x y2 y1 :: ys) xs in
    let expr = Str.split (Str.regexp " +") rpn in
    calc [] expr
end

(* 利用例 *)
let () =
  let rpn = "1 2 + 3 / 4 - 5 *" in
  print_endline (rpn ^ "\n = " ^ string_of_float (RPNCalculator.calculate rpn))
