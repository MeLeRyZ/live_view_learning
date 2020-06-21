defmodule LiveLearn.Licenses do

  @mid_seats 5
  @standard_price 20.0
  @sale_price 15.0
  @max_price_value 100

  def calculate(seats) when seats <= @mid_seats do
    seats * @standard_price
  end

  def calculate(seats) do
    @max_price_value + (seats - @mid_seats) * @sale_price
  end

end
