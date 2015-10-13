-- 逆ポーランド記法電卓 (関数型スタイル3-2)

module RPNCalculator3_2 (
  calculate,
  main
) where

import Control.Applicative ((<*>))
import Data.Char (isDigit)
import Data.List (foldl')

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
calculate rpn = head $ foldl' calc [] expr  -- TODO: 空リストでエラーとならないようにする
  where
    calc stack x
      | all isDigit x = Just (read x :: Double) : stack
      | otherwise     =
        case stack of
          (y1:y2:ys) -> (opeFn x <*> y2 <*> y1) : ys
          _          -> [Nothing]  -- TODO: RPNCalculator3_1と同様の振る舞いをするように書き換える
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
