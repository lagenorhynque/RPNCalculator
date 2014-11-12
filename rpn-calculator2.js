// 逆ポーランド記法電卓 (関数型スタイル)

var _ = require("underscore");

var RPNCalculator2 = (function () {
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
      var head;
      var tail;

      if (_.isEmpty(expr)) {
        return stack[0];
      }

      head = _.first(expr);
      tail = _.rest(expr);
      if (/^\d+$/.test(head)) {
        return calc([parseInt(head, 10)].concat(stack), tail);
      } else {
        return calc([opeFn(head)(stack[0], stack[1])].concat(_.rest(stack, 2)), tail);
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
  return {
    calculate: calculate
  };
}());

// 利用例
(function () {
  var rpn = "1 2 + 3 / 4 - 5 *";
  console.log(rpn, "\n = ", RPNCalculator2.calculate(rpn));
}());
