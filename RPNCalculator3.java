// 逆ポーランド記法電卓 (関数型スタイル2)

import java.util.Arrays;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;

class RPNCalculator3 {
  private static final Map<String, BinaryOperator<Double>> OPERATORS;

  static {
    final Map<String, BinaryOperator<Double>> map = new HashMap<>();
    map.put("+", (x, y) -> y + x);
    map.put("-", (x, y) -> y - x);
    map.put("*", (x, y) -> y * x);
    map.put("/", (x, y) -> y / x);
    OPERATORS = Collections.unmodifiableMap(map);
  }

  public static double calculate(final String rpn) {
    final BiFunction<Deque<Double>, String, Deque<Double>> calc = (stack, x) -> {
      if (x.chars().allMatch(Character::isDigit)) {
        stack.addFirst(Double.parseDouble(x));
        return stack;
      } else if (stack.size() >= 2) {
        final double res = opeFn(x).apply(stack.removeFirst(), stack.removeFirst());
        stack.addFirst(res);
        return stack;
      } else {
        throw new IllegalArgumentException("unexpected pattern found");
      }
    };
    return Arrays.stream(rpn.split("\\s+"))
      .reduce(new ArrayDeque<>(), calc, (l, r) -> {
        l.addAll(r);
        return l;
      })
      .removeFirst();
  }

  private static BinaryOperator<Double> opeFn(final String ope) {
    if (OPERATORS.containsKey(ope)) {
      return OPERATORS.get(ope);
    } else {
      throw new IllegalArgumentException(
        String.format("unsupported operator '%s' is used", ope));
    }
  }

  public static void main(final String[] args) {
    // 利用例
    final String rpn = "1 2 + 3 / 4 - 5 *";
    System.out.printf("%s%n = %s%n", rpn, calculate(rpn));
  }
}
