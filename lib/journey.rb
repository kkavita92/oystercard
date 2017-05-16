class FareError < StandardError; end

class Journey

  attr_reader :complete, :entry_station, :exit_station

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def fare
    return PENALTY_FARE if penalty?
    MIN_FARE
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
    @complete = true
  end

  def complete?
    @complete
  end

  private


  def penalty?
    entry_station == nil || exit_station == nil
  end

end
