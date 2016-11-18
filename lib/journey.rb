require './lib/oyster.rb'

class Journey

attr_reader :entry_station, :exit_station, :trip
MINIMUM_FARE = 1
PENALTY_FARE = 6
#calculate the journey
  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @trip = {entry_station: nil, exit_station: nil}
  end

  def save_entry(station)
    @entry_station = station
    @trip[:entry_station] = station
  end

  def save_exit(station)
    @exit_station = station
    @trip[:exit_station] = station
  end

  def complete?
    @trip[:entry_station] != nil && @trip[:exit_station] != nil
  end

  def partly_complete?
    (@trip[:entry_station] == nil && @trip[:exit_station] != nil) || (@trip[:entry_station] != nil && @trip[:exit_station] == nil)
  end

  # def save_journey
  #   @complete_journey[@entry_station] = @exit_station
  # end


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
