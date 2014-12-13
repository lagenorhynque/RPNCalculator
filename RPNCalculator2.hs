-- 逆ポーランド記法電卓 (関数型スタイル2)

module RPNCalculator2 (
  calculate,
  main
) where

import Data.Char (isDigit)
import Data.List (foldl')

calculate :: String -> Double
calculate rpn = head $ foldl' calc [] expr
  where
    calc stack x
      | all isDigit x = (read x :: Double) : stack
      | otherwise     =
        case stack of
          (y1:y2:ys) -> opeFn x y2 y1 : ys
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
