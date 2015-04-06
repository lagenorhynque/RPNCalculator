(* 逆ポーランド記法電卓 (関数型スタイル2) *)

#load "str.cma"

module RPNCalculator2 : sig
  val calculate : string -> float
end = struct
  let ope_fn = function
    | "+" -> (+.)
    | "-" -> (-.)
    | "*" -> ( *. )
    | "/" -> (/.)
    | ope -> failwith ("unsupported operator '" ^ ope ^ "' is used")

  let calculate rpn =
    let calc stack = function
    | x when Str.string_match (Str.regexp "^[0-9]+$") x 0 ->
      float_of_string x :: stack
    | x -> match stack with
      | y1 :: y2 :: ys -> ope_fn x y2 y1 :: ys
      | _ -> failwith "unexpected pattern found" in
    let expr = Str.split (Str.regexp " +") rpn in
    List.hd (List.fold_left calc [] expr)
end

(* 利用例 *)
let () =
  let rpn = "1 2 + 3 / 4 - 5 *" in
  print_endline (rpn ^ "\n = " ^ string_of_float (RPNCalculator2.calculate rpn))
