class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    return PENALTY_FARE unless complete?
    MIN_FARE
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  private


  def complete?
    entry_station != nil  && exit_station != nil
  end

end
