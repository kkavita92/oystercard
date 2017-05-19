require_relative './station'
require_relative './journey'
require_relative './journeylog'

class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station, :journey_log

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize(balance = DEFAULT_BALANCE, journey_log = JourneyLog.new)
    @journey_log = journey_log
    @balance = balance
  end

  def top_up(amount)
    raise(BalanceError, 'requested top-up amount exceeds limit!') if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise(BalanceError, 'balance is too low') if insufficient_balance?
    reset_journey if journey_log.current_journey != nil
    journey_log.start(station)
  end

  def touch_out(station)
    if journey_log.current_journey == nil
      journey_log.start(nil)
    end
    journey_log.finish(station)
    deduct_fare(journey_log.charge)
    journey_log.reset
  end

  private

  def insufficient_balance?
    @balance < Journey::MIN_FARE
  end


  def deduct_fare(fare)
    @balance -= fare
  end

  def reset_journey
    journey_log.finish(nil)
    deduct_fare(journey_log.charge)
  end


end
