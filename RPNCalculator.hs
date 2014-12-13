-- 逆ポーランド記法電卓 (関数型スタイル)

module RPNCalculator (
  calculate,
  main
) where

import Data.Char (isDigit)

calculate :: String -> Double
calculate rpn = calc [] expr
  where
    calc stack [] = head stack
    calc stack (x:xs)
      | all isDigit x = calc ((read x :: Double) : stack) xs
      | otherwise     =
        case stack of
          (y1:y2:ys) -> calc (opeFn x y2 y1 : ys) xs
    expr = words rpn

opeFn :: Fractional a => String -> a -> a -> a
opeFn "+" = (+)
opeFn "-" = (-)
opeFn "*" = (*)
opeFn "/" = (/)
opeFn ope = error $ "unsupported operator '" ++ ope ++ "' is used"

-- 利用例
main :: IO ()
main = putStrLn $ rpn ++ "\n = " ++ show (calculate rpn)
  where
    rpn = "1 2 + 3 / 4 - 5 *"
