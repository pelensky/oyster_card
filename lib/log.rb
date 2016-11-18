require "oyster"

class Log

attr_reader :entry_station, :trip

  def initialize(journey_klass)

    journey = journey_klass
  #  @trip = { entry_station: @entry_station, exit_station: @exit_station }
  end

  def start_journey
    @trip[:entry_station] = @entry_station
  end


end
