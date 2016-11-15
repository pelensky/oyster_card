require './lib/station'

class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(balance = 0)
  @balance = balance
  @maximum = MAXIMUM
  @minimum = MINIMUM
  @entry_station = nil
  end


  def top_up(money)
    fail "oystercard has maximum limit of £#{@maximum}" if (@balance + money) > @maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money for single journey" if @balance < @minimum
    @entry_station = station
  end

  def touch_out(fare = @minimum)
    deduct(fare)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end


private
  def deduct(fare)
    @balance -= fare
  end

end
