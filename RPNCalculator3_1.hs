-- 逆ポーランド記法電卓 (関数型スタイル3-1)

module RPNCalculator3_1 (
  calculate,
  main
) where

import Control.Applicative ((<*>))
import Data.Char (isDigit)

-- | 逆ポーランド記法の文字列を読み込み、計算する。
--
-- >>> calculate "1 2 + 3 / 4 - 5 *"
-- Just (-15.0)
-- >>> calculate "1 2 + 3 & 4 - 5 *"
-- Nothing
-- >>> calculate "1 2 + / 3 4 - 5 *"
-- Nothing
-- >>> calculate ""
-- Nothing
calculate :: String -> Maybe Double
calculate rpn = calc [] expr
  where
    calc [] []    = Nothing
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
