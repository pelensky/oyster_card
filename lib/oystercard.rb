require './lib/station'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey, :previous_trips

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(balance = 0)
  @balance = balance
  @maximum = MAXIMUM
  @minimum = MINIMUM
  @entry_station = nil
  @exit_station = nil
  @previous_trips = []
  end


  def top_up(money)
    fail "oystercard has maximum limit of £#{@maximum}" if (@balance + money) > @maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money for single journey" if @balance < @minimum
    @entry_station = station
  end

  def touch_out(station)
    deduct
    @exit_station = station
    @journey = {:entry => @entry_station, :exit => @exit_station}
    @entry_station = nil
    @exit_station = nil
    store_journey
  end

  def store_journey
    @previous_trips << @journey
  end

  def in_journey?
    !!entry_station
  end


private
  def deduct(fare = @minimum)
    @balance -= fare
  end

end
