# 逆ポーランド記法電卓 (手続き型スタイル)

from operator import add, sub, mul, truediv

_OPERATORS = {
    "+": add,
    "-": sub,
    "*": mul,
    "/": truediv
}


def calculate(rpn):
    expr = rpn.split()
    stack = []
    for elem in expr:
        if elem.isdigit():
            stack.append(int(elem))
        elif len(stack) >= 2:
            res = _ope_fn(elem)(stack.pop(-2), stack.pop(-1))
            stack.append(res)
        else:
            raise ValueError("unexpected pattern found")
    return stack.pop()


def _ope_fn(ope):
    if ope in _OPERATORS:
        return _OPERATORS[ope]
    else:
        raise ValueError("unsupported operator '{0}' is used".format(ope))


if __name__ == "__main__":
    # 利用例
    rpn = "1 2 + 3 / 4 - 5 *"
    print(rpn, "\n = ", calculate(rpn))
