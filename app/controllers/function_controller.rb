require_relative '../../lib/func'
require_relative '../../lib/generator'
require_relative '../../lib/neumann'
require_relative '../../lib/metropolis'

class FunctionController < ApplicationController

  def index

    #Получение данных из формы
    @a1 = params[:a].to_f
    @b1 = params[:b].to_f
    @n1 = params[:n].to_i

    #Создание необходимых екземпляров
    generator = Generator.new
    neumann = Neumann.new
    metropolis = Metropolis.new
    f = Func.new

    #Выделение точек для теор. представления
    @points = Hash.new
    dt = 0.001
    step = (0.0..1.0).step(dt).to_a
    step.each { |t|
    value = f.pdf(t,@a1,@b1)
    @points.store(t, value)
    }

    pdf_calculation_lambda = -> (x) { f.pdf(x,@a1,@b1) }
    pdf_maximum_value = f.max(1000,@a1,@b1)

    #генерация методом Неймана
    neumann_method_lambda = -> () { neumann.neumann_method(pdf_calculation_lambda, pdf_maximum_value, 1.0) }
    neumann_method_data = generator.generate(neumann_method_lambda, 0.01, @n1, 1.0)

    #генерация методом Метрополиса
    previous_x_result = 0.5
    metropolis_method_lambda = -> () {
    calculation_result = metropolis.metropolis_method(pdf_calculation_lambda, 1.0, previous_x_result)
    previous_x_result = calculation_result
    calculation_result
     }

    metropolis_method_data = generator.generate(metropolis_method_lambda, 0.01, @n1, 1.0)

    #Выделение точек для представления методом Метрополиса
    @points1 = metropolis_method_data['frequencies']
    @points1.each do |key, value|
    temp = Point.new x: key, y: value, d_type: "metropolis"
    temp.save
    end

    #Выделение точек для представления методом Неймана
    @points2 = neumann_method_data['frequencies']
    @points2.each do |key, value|
    temp = Point.new x: key, y: value, d_type: "neumann"
    temp.save
    end

    @calculation_result = {
            'options' => {
              'count' => @n,
              'a' => @a,
              'b' => @b
            },
            'neumannMethod' => neumann_method_data['frequencies'],
            'metropolisMethod' => metropolis_method_data['frequencies']
          }
        end

  end
