require_relative './station'
require_relative './journey'

class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station, :journeys, :journey

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise(BalanceError, 'requested top-up amount exceeds limit!') if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise(BalanceError, 'balance is too low') if insufficient_balance?
    @journey = Journey.new(station)
    @journeys << { entry_station: @journey.entry_station }
  end

  def touch_out(station)
    deduct_fare
    @journey.end_journey(station)
    @journeys.last[:exit_station] = @journey.exit_station
  end

  private

  def insufficient_balance?
    @balance < MIN_BALANCE
  end


  def deduct_fare
    @balance -= @journey.fare
  end




end
