class Oystercard

  attr_reader :balance

  MAXIMUM = 90

  def initialize(balance = 0)
  @balance = balance
  @maximum = MAXIMUM
  end

  def top_up(money)
    fail "oystercard has maximum limit of £#{@maximum}" if (@balance + money) > @maximum
    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end
end
