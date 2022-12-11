class Generator

  # Генератор точек распределения
  def generate(method, step, count, limit)
    frequencies = Hash.new
    sum = 0
    sum_squares = 0

    ((0 + step)..limit).step(step).each do |currentStep|
      current_success_method_results = 0
      previous_step = currentStep - step

      (0..count).each do
        method_result = method.call
        sum += method_result
        sum_squares += method_result**2

        if method_result > previous_step and method_result <= currentStep
          current_success_method_results += 1
        end
      end

      #frequencies.push(current_success_method_results.to_f / count)
      frequencies.store(currentStep.round(2), current_success_method_results.to_f / count)
    end

    {
      'frequencies' => frequencies,
      'sum' => sum,
      'sum_squares' => sum_squares,
    }
  end

end
