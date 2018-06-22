require './lib/journey'
require './lib/journey_log'

class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :history
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = JourneyLog.new
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if over_limit?(amount)
    @balance += amount
  end

  # def in_journey?
  #   !!entry_station # not entry_station = false not false = true
  # end

  def touch_in(station = nil)
    raise "Insufficient balance to touch in" if low_balance?
    @journeys.start(station)
  end

  def touch_out(station = nil)
    deduct(@journeys.finish(station))
  end

  def low_balance?
    balance < MINIMUM_BALANCE
  end

  def over_limit?(amount)
    amount + @balance > MAXIMUM_BALANCE
  end


 private

  def deduct(amount)
    @balance -= amount
  end
end
