class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if over_limit?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient balance to touch in" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false
  end

  def over_limit?(amount)
    amount + @balance > MAXIMUM_BALANCE
  end

#  private

  def deduct(amount)
    @balance -= amount
  end
end
