# 逆ポーランド記法電卓 (手続き型スタイル)

module RPNCalculator
  OPERATORS = {
    "+" => ->(x, y) { y + x },
    "-" => ->(x, y) { y - x },
    "*" => ->(x, y) { y * x },
    "/" => ->(x, y) { y.fdiv(x) }
  }

  module_function

  def calculate(rpn)
    expr = rpn.split
    stack = []
    expr.each do |elem|
      if elem =~ /^\d+$/
        stack.push(elem.to_i)
      elsif stack.length >= 2
        res = ope_fn(elem).(stack.pop, stack.pop)
        stack.push(res)
      else
        raise ArgumentError, "unexpected pattern found"
      end
    end
    stack.pop
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
  print rpn, "\n = ", RPNCalculator.calculate(rpn), "\n"
end
