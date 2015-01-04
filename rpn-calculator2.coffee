# 逆ポーランド記法電卓 (関数型スタイル)

_ = require("underscore")

RPNCalculator2 = do ->
  "use strict"

  OPERATORS = {
    "+": (x, y) ->
      y + x
    "-": (x, y) ->
      y - x
    "*": (x, y) ->
      y * x
    "/": (x, y) ->
      y / x
  }

  calculate = (rpn) ->
    calc = (stack, expr) ->
      if _.isEmpty(expr)
        return stack[0]

      [head, tail...] = expr
      if /^\d+$/.test(head)
        calc([parseInt(head, 10)].concat(stack), tail)
      else
        calc([opeFn(head)(stack[0], stack[1])].concat(_.rest(stack, 2)), tail)
    calc([], rpn.split(/\s+/))

  opeFn = (ope) ->
    if _.has(OPERATORS, ope)
      OPERATORS[ope]
    else
      throw new Error("unsupported operator '#{ope}' is used")

  {calculate: calculate}

# 利用例
do ->
  rpn = "1 2 + 3 / 4 - 5 *"
  console.log rpn, "\n = ", RPNCalculator2.calculate(rpn)
