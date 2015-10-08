-- 逆ポーランド記法電卓 (関数型スタイル3-1)

module RPNCalculator3_1 (
  calculate,
  main
) where

import Control.Applicative ((<*>))
import Data.Char (isDigit)

calculate :: String -> Maybe Double
calculate rpn = calc [] expr
  where
    calc stack [] = head stack
    calc stack (x:xs)
      | all isDigit x = calc (Just (read x :: Double) : stack) xs
      | otherwise     =
        case stack of
          (y1:y2:ys) -> calc ((opeFn x <*> y2 <*> y1) : ys) xs
          _          -> Nothing
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
