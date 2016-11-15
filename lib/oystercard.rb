class Oystercard

  attr_reader :balance

  MAXIMUM_TOP_UP = 50

  def initialize
    @balance = 0
  end

  def top_up(number)
    raise "You can't top up with a negative number." if number < 0
    raise "You can't top up 0." if number == 0
    raise "You can top up a maximum of #{MAXIMUM_TOP_UP}." if number > MAXIMUM_TOP_UP
    raise 'You can only top up numbers with a max. of 2 decimal places' unless has_no_more_than_two_decimal_places?(number)
    @balance += number
  end

  def deduct_fare(number)
    raise "You can not deduct a negative number." if number < 0
    raise "You can not deduct 0." if number == 0
    raise 'You can only deduct numbers with a max. of 2 decimal places' unless has_no_more_than_two_decimal_places?(number)
    @balance -= number
  end

  def has_no_more_than_two_decimal_places?(number)
    number == number.round(2)
  end

end
