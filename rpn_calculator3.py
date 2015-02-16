# 逆ポーランド記法電卓 (関数型スタイル2)

from functools import reduce
from operator import add, sub, mul, truediv

_OPERATORS = {
    "+": add,
    "-": sub,
    "*": mul,
    "/": truediv
}


def calculate(rpn):
    def calc(stack, x):
        if x.isdigit():
            return [int(x)] + stack
        elif len(stack) >= 2:
            return [_ope_fn(x)(stack[1], stack[0])] + stack[2:]
        else:
            raise ValueError("unexpected pattern found")
    return reduce(calc, rpn.split(), [])[0]


def _ope_fn(ope):
    if ope in _OPERATORS:
        return _OPERATORS[ope]
    else:
        raise ValueError("unsupported operator '{0}' is used".format(ope))


if __name__ == "__main__":
    # 利用例
    rpn = "1 2 + 3 / 4 - 5 *"
    print(rpn, "\n = ", calculate(rpn))
