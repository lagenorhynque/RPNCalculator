# 逆ポーランド記法電卓 (関数型スタイル2)

_ = if require? then require("underscore") else _

RPNCalculator3 = do ->
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
    calc = (stack, x) ->
      if /^\d+$/.test(x)
        [parseInt(x, 10)].concat(stack);
      else
        [opeFn(x)(stack[0], stack[1])].concat(_.rest(stack, 2))
    _.first(_.reduce(rpn.split(/\s+/), calc, []))

  opeFn = (ope) ->
    if _.has(OPERATORS, ope)
      OPERATORS[ope]
    else
      throw new Error("unsupported operator '#{ope}' is used")

  {calculate: calculate}

# 利用例
do ->
  rpn = "1 2 + 3 / 4 - 5 *"
  console.log rpn, "\n = ", RPNCalculator3.calculate(rpn)
