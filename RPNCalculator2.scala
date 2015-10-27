// 逆ポーランド記法電卓 (関数型スタイル2)

object RPNCalculator2 {
  def calculate(rpn: String): Double = {
    def calc(stack: List[Double], x: String): List[Double] =
      if (x.forall(_.isDigit)) {
        x.toDouble :: stack
      } else {
        stack match {
          case y1 :: y2 :: ys =>
            opeFn(x)(y2, y1) :: ys
          case _ => throw new IllegalArgumentException("unexpected pattern found")
        }
      }

    val expr = rpn.split("""\s+""").toList: List[String]
    expr.foldLeft(List[Double]())(calc).head
  }

  private def opeFn(ope: String): (Double, Double) => Double =
    ope match {
      case "+" => _ + _
      case "-" => _ - _
      case "*" => _ * _
      case "/" => _ / _
      case _ => throw new IllegalArgumentException(s"unsupported operator '${ope}' is used")
    }

  def main(args: Array[String]): Unit = {
    // 利用例
    val rpn = "1 2 + 3 / 4 - 5 *"
    println(s"${rpn}\n = ${calculate(rpn)}")
  }
}
