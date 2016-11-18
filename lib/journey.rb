require './lib/oyster.rb'

class Journey

attr_reader :entry_station, :exit_station, :trip
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def initialize
    @entry_station = entry_station
    @exit_station = exit_station
    @trip = { entry_station: @entry_station, exit_station: @exit_station }
  end

  def save_entry(station)
    @entry_station = station

  end

  def start_journey
    @trip[:entry_station] = @entry_station
  end



  def save_exit(station)
    @exit_station = station
  end

  def end_journey
    @trip[:exit_station] = @exit_station
  end

  def complete?
    @trip[:entry_station] != nil && @trip[:exit_station] != nil
  end

  def partly_complete?
    no_touch_in = @trip[:entry_station].nil? && !@trip[:exit_station].nil?
    no_touch_out = !@trip[:entry_station].nil? && @trip[:exit_station].nil?
    no_touch_in or no_touch_out
  end

def reset
  delete_entry
  delete_exit
end

def fare
  return MINIMUM_FARE if complete?
  PENALTY_FARE
end

private

  def delete_entry
    @entry_station = nil
  end

  def delete_exit
    @exit_station = nil
  end

end
