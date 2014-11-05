// 逆ポーランド記法電卓 (関数型スタイル)

import java.util.Arrays;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;

import org.apache.commons.lang3.math.NumberUtils;

class RPNCalculator2 {
  private static final Map<String, BinaryOperator<Double>> OPERATORS;

  private static BiFunction<Deque<Double>, List<String>, Double> calc;

  static {
    final Map<String, BinaryOperator<Double>> map = new HashMap<>();
    map.put("+", (x, y) -> y + x);
    map.put("-", (x, y) -> y - x);
    map.put("*", (x, y) -> y * x);
    map.put("/", (x, y) -> y / x);
    OPERATORS = Collections.unmodifiableMap(map);
  }

  public static double calculate(final String rpn) {
    calc = (stack, expr) -> {
      if (expr.isEmpty()) {
        return stack.removeFirst();
      }

      final String head = expr.get(0);
      final List<String> tail = expr.subList(1, expr.size());
      if (NumberUtils.isDigits(head)) {
        stack.addFirst(Double.parseDouble(head));
        return calc.apply(stack, tail);
      } else {
        final double res = opeFn(head).apply(stack.removeFirst(), stack.removeFirst());
        stack.addFirst(res);
        return calc.apply(stack, tail);
      }
    };
    return calc.apply(new ArrayDeque<>(), Arrays.asList(rpn.split("\\s+")));
  }

  private static BinaryOperator<Double> opeFn(String ope) {
    if (OPERATORS.containsKey(ope)) {
      return OPERATORS.get(ope);
    } else {
      throw new UnsupportedOperationException(
        String.format("unsupported operator '%s' is used", ope));
    }
  }

  public static void main(final String[] args) {
    // 利用例
    final String rpn = "1 2 + 3 / 4 - 5 *";
    System.out.printf("%s%n = %s%n", rpn, calculate(rpn));
  }
}
