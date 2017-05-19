class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def start(station)
    #reset_journey unless @current_journey.complete?
    @current_journey = @journey_class.new(station)
    @journeys << { entry_station: station }
  end

  def finish(station)
    @current_journey.end_journey(station)
    @journeys.last[:exit_station] = station #needs to reset current journey
  end

  def journeys
    @journeys.dup
  end

  def charge
    @current_journey.fare
  end

  def reset
    @current_journey = nil
  end


  #def current_journey
  #  @current_journey ||= Journey.new
  #end


end
