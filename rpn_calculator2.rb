# 逆ポーランド記法電卓 (関数型スタイル)

module RPNCalculator2
  OPERATORS = {
    "+" => ->(x, y) { y + x },
    "-" => ->(x, y) { y - x },
    "*" => ->(x, y) { y * x },
    "/" => ->(x, y) { y.fdiv(x) }
  }

  module_function

  def calculate(rpn)
    def self.calc(stack, expr)
      if expr.empty?
        return stack[0]
      end

      x, *xs = expr
      if x =~ /^\d+$/
        calc([x.to_i] + stack, xs)
      else
        calc([ope_fn(x).call(stack[0], stack[1])] + stack[2..-1], xs)
      end
    end
    calc([], rpn.split)
  end

  def ope_fn(ope)
    if OPERATORS.include?(ope)
      OPERATORS[ope]
    else
      raise NameError, "unsupported operator '#{ope}' is used"
    end
  end

  private_class_method :ope_fn
end

if __FILE__ == $0
  # 利用例
  rpn = "1 2 + 3 / 4 - 5 *"
  print rpn, "\n = ", RPNCalculator2.calculate(rpn), "\n"
end
