# 逆ポーランド記法電卓 (関数型スタイル2)

"use strict"

_ = if require? then require("underscore") else this._

OPERATORS = {
  "+": (x, y) -> y + x
  "-": (x, y) -> y - x
  "*": (x, y) -> y * x
  "/": (x, y) -> y / x
}

calculate = (rpn) ->
  calc = (stack, x) ->
    if /^[+-]?\d+$/.test(x)
      [parseInt(x, 10)].concat(stack);
    else
      [opeFn(x)(stack[0], stack[1])].concat(_.rest(stack, 2))
  _.first(_.reduce(rpn.split(/\s+/), calc, []))

opeFn = (ope) ->
  if _.has(OPERATORS, ope)
    OPERATORS[ope]
  else
    throw new Error("unsupported operator '#{ope}' is used")

RPNCalculator3 = {calculate: calculate}
if module?.exports?
  module.exports = RPNCalculator3
else
  this.RPNCalculator3 = RPNCalculator3

# 利用例
rpn = "1 2 + 3 / 4 - 5 *"
console.log rpn, "\n = ", RPNCalculator3.calculate(rpn)
