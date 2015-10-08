-- 逆ポーランド記法電卓 (関数型スタイル3-2)

module RPNCalculator3_2 (
  calculate,
  main
) where

import Control.Applicative ((<*>))
import Data.Char (isDigit)
import Data.List (foldl')

calculate :: String -> Maybe Double
calculate rpn = head $ foldl' calc [] expr
  where
    calc stack x
      | all isDigit x = Just (read x :: Double) : stack
      | otherwise     =
        case stack of
          (y1:y2:ys) -> (opeFn x <*> y2 <*> y1) : ys
          _          -> [Nothing]
    expr = words rpn

opeFn :: Fractional a => String -> Maybe (a -> a -> a)
opeFn "+" = Just (+)
opeFn "-" = Just (-)
opeFn "*" = Just (*)
opeFn "/" = Just (/)
opeFn _   = Nothing

-- 利用例
main :: IO ()
main = putStrLn $ rpn ++ "\n = " ++ maybe "invalid" show (calculate rpn)
  where
    rpn = "1 2 + 3 / 4 - 5 *"
