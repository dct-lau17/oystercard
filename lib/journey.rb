class Journey

  attr_reader :entry_station, :exit_station, :trip

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
    @complete = false
  end

  def exit(station = nil )
    @complete = true
    @exit_station = station
    @trip = {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def complete?
    @complete
  end

  def penalty?
    (entry_station.nil? || exit_station.nil?)
  end

  def fare
    return PENALTY_FARE if penalty?
    MINIMUM_FARE
  end

end
