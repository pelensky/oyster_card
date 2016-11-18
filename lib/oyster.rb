require './lib/journey.rb'

class Oyster
  attr_reader :balance, :in_journey, :journey, :journey_history
  DEFAULT_BALANCE = 0
  MAX_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance
    @journey = journey
    @journey_history = []
  end

  def top_up(money)
    message = "The limit for topping up is #{MAX_CAPACITY} pounds"
    fail message if max_capacity?(money)
    @balance += money
  end

  def touch_in(station)
    deduct if journey.partly_complete?
    message = "You're poor, go and top up"
    fail message if @balance < MINIMUM_FARE
    journey.save_entry(station)
  end

  def touch_out(station)
    journey.save_exit(station)
    deduct()
    save_history
  end

  private

  def save_history
    @journey_history << journey.trip
    journey.reset
  end

  def deduct
    @balance -= journey.fare
  end

  def max_capacity?(money)
    @balance + money > MAX_CAPACITY
  end

end
