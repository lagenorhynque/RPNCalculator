// 逆ポーランド記法電卓 (手続き型スタイル)

(function () {
  "use strict";

  var _ = typeof require !== "undefined" ? require("underscore") : this._;

  var OPERATORS = {
    "+": function (x, y) {
      return y + x;
    },
    "-": function (x, y) {
      return y - x;
    },
    "*": function (x, y) {
      return y * x;
    },
    "/": function (x, y) {
      return y / x;
    }
  };

  var calculate = function (rpn) {
    var expr = rpn.split(/\s+/);
    var stack = [];
    var len = expr.length;
    var i;
    var elem;
    var res;

    for (i = 0; i < len; i += 1) {
      elem = expr[i];
      if (/^\d+$/.test(elem)) {
        stack.push(parseInt(elem, 10));
      } else {
        res = opeFn(elem)(stack.pop(), stack.pop());
        stack.push(res);
      }
    }
    return stack.pop();
  };

  var opeFn = function (ope) {
    if (_.has(OPERATORS, ope)) {
      return OPERATORS[ope];
    } else {
      throw new Error("unsupported operator '" + ope + "' is used");
    }
  };

  var RPNCalculator = {
    calculate: calculate
  };
  if (typeof module !== "undefined" && module.exports) {
    module.exports = RPNCalculator;
  } else {
    this.RPNCalculator = RPNCalculator;
  }

  // 利用例
  var rpn = "1 2 + 3 / 4 - 5 *";
  console.log(rpn, "\n = ", RPNCalculator.calculate(rpn));
}.call(this));
