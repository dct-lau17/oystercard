require './lib/journey'
class JourneyLog
  attr_reader :entry_station, :exit_station
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
    @journey = @journey_class.new(entry_station)
    p @journey
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journey.exit(exit_station)
    store_journey
    fare
  end

  def journeys
    @journeys.dup
  end

private

  def current_journey
    {entry: entry_station, exit: exit_station}
  end

  def store_journey
    @journeys << current_journey
  end

  def fare
    @journey.fare
  end

end
