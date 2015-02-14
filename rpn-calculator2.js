// 逆ポーランド記法電卓 (関数型スタイル)

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
    var calc = function calc (stack, expr) {
      var x;
      var xs;

      if (_.isEmpty(expr)) {
        return stack[0];
      }

      x = _.first(expr);
      xs = _.rest(expr);
      if (/^[+-]?\d+$/.test(x)) {
        return calc([parseInt(x, 10)].concat(stack), xs);
      } else {
        return calc([opeFn(x)(stack[0], stack[1])].concat(_.rest(stack, 2)), xs);
      }
    };
    return calc([], rpn.split(/\s+/));
  };

  var opeFn = function (ope) {
    if (_.has(OPERATORS, ope)) {
      return OPERATORS[ope];
    } else {
      throw new Error("unsupported operator '" + ope + "' is used");
    }
  };

  var RPNCalculator2 =  {
    calculate: calculate
  };
  if (typeof module !== "undefined" && module.exports) {
    module.exports = RPNCalculator2;
  } else {
    this.RPNCalculator2 = RPNCalculator2;
  }

  // 利用例
  var rpn = "1 2 + 3 / 4 - 5 *";
  console.log(rpn, "\n = ", RPNCalculator2.calculate(rpn));
}.call(this));
