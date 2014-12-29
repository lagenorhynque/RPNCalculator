# 逆ポーランド記法電卓 (手続き型スタイル)

_ = require("underscore")

RPNCalculator = do ->
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
    expr = rpn.split(/\s+/)
    stack = []
    for elem in expr
      if /^\d+$/.test(elem)
        stack.push(parseInt(elem, 10))
      else
        res = opeFn(elem)(stack.pop(), stack.pop())
        stack.push(res)
    stack.pop()

  opeFn = (ope) ->
    if _.has(OPERATORS, ope)
      OPERATORS[ope]
    else
      throw new Error("unsupported operator '#{ope}' is used")

  {calculate: calculate}

# 利用例
do ->
  rpn = "1 2 + 3 / 4 - 5 *"
  console.log rpn, "\n = ", RPNCalculator.calculate(rpn)
