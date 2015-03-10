// 逆ポーランド記法電卓 (関数型スタイル)

import scala.annotation.tailrec

object RPNCalculator {
  def calculate(rpn: String): Double = {
    @tailrec
    def calc(stack: List[Double], expr: List[String]): Double = {
      expr match {
        case Nil => stack.head
        case x :: xs =>
          if (x.forall { _.isDigit }) {
            calc(x.toDouble :: stack, xs)
          } else {
            stack match {
              case y1 :: y2 :: ys =>
                calc(opeFn(x)(y2, y1) :: ys, xs)
              case _ => throw new IllegalArgumentException("unexpected pattern found")
            }
          }
      }
    }
    val expr = rpn.split("""\s+""").toList
    calc(List(), expr)
  }

  private def opeFn(ope: String): (Double, Double) => Double = {
    ope match {
      case "+" => _ + _
      case "-" => _ - _
      case "*" => _ * _
      case "/" => _ / _
      case _ => throw new IllegalArgumentException(s"unsupported operator '${ope}' is used")
    }
  }

  def main(args: Array[String]): Unit = {
    // 利用例
    val rpn = "1 2 + 3 / 4 - 5 *"
    println(s"${rpn}\n = ${calculate(rpn)}")
  }
}
