# 逆ポーランド記法電卓 (手続き型スタイル)

"use strict"

_ = if require? then require("underscore") else this._

OPERATORS = {
  "+": (x, y) -> y + x
  "-": (x, y) -> y - x
  "*": (x, y) -> y * x
  "/": (x, y) -> y / x
}

calculate = (rpn) ->
  expr = rpn.split(/\s+/)
  stack = []
  for elem in expr
    if /^\d+$/.test(elem)
      stack.push(parseInt(elem, 10))
    else if stack.length >= 2
      res = opeFn(elem)(stack.pop(), stack.pop())
      stack.push(res)
    else
      throw new Error("unexpected pattern found")
  stack.pop()

opeFn = (ope) ->
  if _.has(OPERATORS, ope)
    OPERATORS[ope]
  else
    throw new Error("unsupported operator '#{ope}' is used")

RPNCalculator = {calculate: calculate}
if module?.exports?
  module.exports = RPNCalculator
else
  this.RPNCalculator = RPNCalculator

# 利用例
rpn = "1 2 + 3 / 4 - 5 *"
console.log rpn, "\n = ", RPNCalculator.calculate(rpn)
