class Neumann

  # Метод Неймана
  def neumann_method(function_callback, max, right)
    while true
      x = rand(0.0..1.0) * right
      y = rand(0.0..1.0) * maximum

      if function_callback.call(x) > y
        return x
      end
    end
  end

end
