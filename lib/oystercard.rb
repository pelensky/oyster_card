class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(number)
    raise "You can't top up with a negative number." if number < 0
    @balance += number
  end

end
