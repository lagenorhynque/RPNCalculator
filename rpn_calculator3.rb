# 逆ポーランド記法電卓 (関数型スタイル2)

module RPNCalculator3
  OPERATORS = {
    "+" => ->(x, y) { y + x },
    "-" => ->(x, y) { y - x },
    "*" => ->(x, y) { y * x },
    "/" => ->(x, y) { y.fdiv(x) }
  }

  module_function

  def calculate(rpn)
    rpn.split.inject([]) { |stack, x|
      if x =~ /^\d+$/
        [x.to_i] + stack
      elsif stack.length >= 2
        [ope_fn(x).(stack[0], stack[1])] + stack[2..-1]
      else
        raise ArgumentError, "unexpected pattern found"
      end
    }[0]
  end

  def ope_fn(ope)
    if OPERATORS.include?(ope)
      OPERATORS[ope]
    else
      raise ArgumentError, "unsupported operator '#{ope}' is used"
    end
  end

  private_class_method :ope_fn
end

if __FILE__ == $0
  # 利用例
  rpn = "1 2 + 3 / 4 - 5 *"
  print rpn, "\n = ", RPNCalculator3.calculate(rpn), "\n"
end
