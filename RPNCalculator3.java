// 逆ポーランド記法電卓 (関数型スタイル2)

import java.util.Arrays;
import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;

import org.apache.commons.lang3.math.NumberUtils;

class RPNCalculator3 {
  private static final Map<String, BinaryOperator<Double>> OPERATORS;

  private static BiFunction<Deque<Double>, String, Deque<Double>> calc;

  static {
    final Map<String, BinaryOperator<Double>> map = new HashMap<>();
    map.put("+", (x, y) -> y + x);
    map.put("-", (x, y) -> y - x);
    map.put("*", (x, y) -> y * x);
    map.put("/", (x, y) -> y / x);
    OPERATORS = Collections.unmodifiableMap(map);
  }

  public static double calculate(final String rpn) {
    calc = (stack, x) -> {
      if (NumberUtils.isDigits(x)) {
        stack.addFirst(Double.parseDouble(x));
        return stack;
      } else {
        final double res = opeFn(x).apply(stack.removeFirst(), stack.removeFirst());
        stack.addFirst(res);
        return stack;
      }
    };
    // FIXME: コンパイルエラーを解消
    return Arrays.stream(rpn.split("\\s+"))
      .reduce(new ArrayDeque<>(), calc, (l, r) -> l.addAll(r))
      .removeFirst();
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
