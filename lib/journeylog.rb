class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    reset_journey if incomplete_journey? #should charge penalty fare #need to change to nil?
    @current_journey = @journey_class.new(station)
    @journeys << { entry_station: station }
  end

  def finish(station)
    @current_journey.end_journey(station)
    @journeys.last[:exit_station] = station
  end

  def journeys
    @journeys.dup
  end

  def incomplete_journey?
    !@current_journey.complete?
  end

  def pending_charges
    @current_journey.fare
  end

  private

  def reset_journey
    @current_journey.end_journey
  end


  #def current_journey
  #  @current_journey ||= Journey.new
  #end


end
