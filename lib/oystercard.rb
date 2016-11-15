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
    @balance += number
  end

end
