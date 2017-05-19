class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    return PENALTY_FARE unless complete?
    MIN_FARE + absolute_zone_difference
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  private

  def absolute_zone_difference
    (@entry_station.zone - @exit_station.zone).abs
  end

  def complete?
    entry_station != nil  && exit_station != nil
  end

end
