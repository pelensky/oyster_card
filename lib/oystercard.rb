class Oystercard

  attr_reader :balance, :in_journey

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(balance = 0)
  @balance = balance
  @maximum = MAXIMUM
  @minimum = MINIMUM
  @in_journey = false
  end

  def top_up(money)
    fail "oystercard has maximum limit of £#{@maximum}" if (@balance + money) > @maximum
    @balance += money
  end

  def touch_in
    fail "Not enough money for single journey" if @balance < @minimum
    @in_journey = true
  end

  def touch_out(fare = @minimum)
    @in_journey = false
    deduct(fare)
  end

private
  def deduct(fare)
    @balance -= fare
  end

end
