require './lib/station'
require './lib/journey'

class Oystercard

  attr_reader :balance

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(balance = 0)
  @balance = balance
  @maximum = MAXIMUM
  @minimum = MINIMUM
  @journey = Journey.new
  end

  def top_up(money)
    fail "oystercard has maximum limit of £#{@maximum}" if (@balance + money) > @maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money for single journey" if @balance < @minimum
    @journey.entry_station_registered(station)
  end

  def touch_out(station)
    deduct
    @journey.exit_station_registered(station)
    @journey.storing_the_journey
    @journey.reset_stations
    @journey.storing_to_trips
  end

private
  def deduct(fare = @minimum)
    @balance -= fare
  end

end
