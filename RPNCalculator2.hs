-- 逆ポーランド記法電卓 (関数型スタイル2)

module RPNCalculator2 (
  calculate,
  main
) where

import Data.Char (isDigit)
import Data.List (foldl')

-- | 逆ポーランド記法の文字列を読み込み、計算する。
--
-- >>> calculate "1 2 + 3 / 4 - 5 *"
-- -15.0
-- >>> calculate "1 2 + 3 & 4 - 5 *"
-- *** Exception: unsupported operator '&' is used
-- >>> calculate "1 2 + / 3 4 - 5 *"
-- *** Exception: unexpected pattern found
-- >>> calculate ""
-- *** Exception: empty input
calculate :: String -> Double
calculate rpn = case expr of
  [] -> error "empty input"
  _  -> head $ foldl' calc [] expr
  where
    calc stack x
      | all isDigit x = (read x :: Double) : stack
      | otherwise     =
        case stack of
          (y1:y2:ys) -> opeFn x y2 y1 : ys
          _          -> error "unexpected pattern found"
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
