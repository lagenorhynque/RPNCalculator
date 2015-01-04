// 逆ポーランド記法電卓 (関数型スタイル2)

var _ = require("underscore");

var RPNCalculator3 = (function () {
  "use strict";

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
    var calc = function (stack, x) {
      if (/^\d+$/.test(x)) {
        return [parseInt(x, 10)].concat(stack);
      } else {
        return [opeFn(x)(stack[0], stack[1])].concat(_.rest(stack, 2));
      }
    };
    return _.first(_.reduce(rpn.split(/\s+/), calc, []));
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
  console.log(rpn, "\n = ", RPNCalculator3.calculate(rpn));
}());
