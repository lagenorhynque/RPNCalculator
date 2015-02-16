# 逆ポーランド記法電卓 (関数型スタイル)

from operator import add, sub, mul, truediv

_OPERATORS = {
    "+": add,
    "-": sub,
    "*": mul,
    "/": truediv
}


def calculate(rpn):
    def calc(stack, expr):
        if not expr:
            return stack[0]

        x, *xs = expr
        if x.isdigit():
            return calc([int(x)] + stack, xs)
        elif len(stack) >= 2:
            return calc([_ope_fn(x)(stack[1], stack[0])] + stack[2:], xs)
        else:
            raise ValueError("unexpected pattern found")
    return calc([], rpn.split())


def _ope_fn(ope):
    if ope in _OPERATORS:
        return _OPERATORS[ope]
    else:
        raise ValueError("unsupported operator '{0}' is used".format(ope))


if __name__ == "__main__":
    # 利用例
    rpn = "1 2 + 3 / 4 - 5 *"
    print(rpn, "\n = ", calculate(rpn))
