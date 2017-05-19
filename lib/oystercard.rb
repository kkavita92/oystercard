require_relative './station'
require_relative './journey'
require_relative './journeylog'

class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station, :journey_log

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

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
    journey_log.start(station)
  end

  def touch_out(station)
    journey_log.finish(station)
    deduct_fare
  end

  private

  def insufficient_balance?
    @balance < MIN_BALANCE
  end


  def deduct_fare
    @balance -= journey_log.pending_charges
  end


end
