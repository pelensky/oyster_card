require './lib/journey.rb'

class Oyster
attr_reader :balance, :in_journey, :entry_station, :exit_station, :journey, :journey_history
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
  message = "You're poor, go and top up"
  fail message if @balance < MINIMUM_FARE
  journey.save_entry(station)
end

def touch_out(station)
  deduct()
  journey.save_exit(station)
  journey.save_journey
  save_history
  journey.reset
end

private


def save_history
  @journey_history << journey.complete_journey
end

def deduct(money = MINIMUM_FARE)
  @balance -= money
end

def max_capacity?(money)
  @balance + money > MAX_CAPACITY
end

end
