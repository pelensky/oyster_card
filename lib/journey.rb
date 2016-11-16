require './lib/oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :trip, :previous_trips


  def initialize
  @entry_station = nil
  @exit_station = nil
  @previous_trips = []
  end

  def entry_station_registered(station)
    @entry_station = station
  end

  def exit_station_registered(station)
    @exit_station = station
  end

  def storing_the_journey
    @trip = {:entry => @entry_station, :exit => @exit_station}
  end

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end

  def storing_to_trips
    @previous_trips << @trip
  end

  def in_journey?
    !!entry_station
  end




end
