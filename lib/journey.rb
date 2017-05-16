class FareError < StandardError; end

class Journey

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def fare
    PENALTY_FARE unless complete?
    MIN_FARE
  end

  def journey_end(exit_station = nil)
    @exit_station = exit_station
    @complete = true
  end

  def complete?
    @complete
  end

  def penalty?
    !(entry_station == nil || exit_station == nil)
  end

end
