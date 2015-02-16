// 逆ポーランド記法電卓 (手続き型スタイル)

import java.util.ArrayDeque;
import java.util.Deque;

import org.apache.commons.lang3.math.NumberUtils;

class RPNCalculator {
  public static double calculate(String rpn) {
    String[] expr = rpn.split("\\s+");
    Deque<Double> stack = new ArrayDeque<>();
    for (String elem : expr) {
      if (NumberUtils.isDigits(elem)) {
        stack.addFirst(Double.parseDouble(elem));
      } else {
        double res = opeFn(elem, stack.removeFirst(), stack.removeFirst());
        stack.addFirst(res);
      }
    }
    return stack.removeFirst();
  }

  private static double opeFn(String ope, double x, double y) {
    switch (ope) {
      case "+":
        return y + x;
      case "-":
        return y - x;
      case "*":
        return y * x;
      case "/":
        return y / x;
      default:
        throw new IllegalArgumentException(
          String.format("unsupported operator '%s' is used", ope));
    }
  }

  public static void main(String[] args) {
    // 利用例
    String rpn = "1 2 + 3 / 4 - 5 *";
    System.out.printf("%s%n = %s%n", rpn, calculate(rpn));
  }
}
