class FareError < StandardError; end

class Journey

  attr_reader :complete, :entry_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def fare
  end

  def end_journey(exit_station)
  end 

  def complete?
    @complete
  end
=begin
  PENALTY_FARE = 6


  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def fare
    PENALTY_FARE unless complete?
    2
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
=end
end
