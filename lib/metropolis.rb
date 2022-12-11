class Metropolis

  # Метод Метрополиса
  def metropolis_method(function_callback, right, x)
    g1 = rand(0.0..1.0)
    g2 = rand(0.0..1.0)
    d = (1.0/3.0) * right

    x1 = x + d * (-1.0 + 2.0 * g1)

    if x1 < 0 || x1 > right
      return x
    end

    x_calc = function_callback.call(x)
    a = function_callback.call(x1) / x_calc

    if a >= 1.0 || a > g2
      return x1
    end
    x
  end
end
