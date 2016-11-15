class Balance

  attr_reader :amount

  def initialize
    @amount = 0
  end

  def add_amount(number)
    @amount += number
  end

  def deduct_amount(number)
    @amount -= number
  end

  def has_no_more_than_two_decimal_places?(number)
    number == number.round(2)
  end

  def is_integer_or_float?(number)
    number.is_a?(Integer) || number.is_a?(Float)
  end

end
