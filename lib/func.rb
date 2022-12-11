class Func

  # Максимальное знач. через формулу PDF распределения Кумарасвами
  def max(count, a, b)
    m = pdf(0.0,a,b)
    i = 1
    while i <= count do
      x = (1.0 - 0.0).to_f / count * i
      fi = pdf(x,a,b)
      m = fi if fi > m
      i += 1
    end
    return m
  end

  # Формула PDF распределения Кумарасвами
  def pdf(x, a, b)
  a*b*(x**(a-1))*(1-x**a)**(b-1)
  end

 end
