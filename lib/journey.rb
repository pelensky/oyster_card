require './lib/oyster.rb'

class Journey

attr_reader :entry_station, :exit_station, :complete_journey
MINIMUM_FARE = 1

#calculate the journey
  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @complete_journey = {}
  end

  def save_entry(station)
    @entry_station = station
  end



  def save_exit(station)
    @exit_station = station
  end

  def save_journey
    @complete_journey[@entry_station] = @exit_station
  end


def reset
  delete_entry
  delete_exit
end

def fare
  MINIMUM_FARE
end

private

  def delete_entry
    @entry_station = nil
  end

  def delete_exit
    @exit_station = nil
  end

end
