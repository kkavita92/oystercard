class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 4

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(topup_amount)
    raise(BalanceError, 'requested top-up amount exceeds limit!') if (@balance + topup_amount) > MAX_BALANCE
    @balance += topup_amount
  end

  def touch_in(station)
    raise(BalanceError, 'balance is too low') if insufficient_balance?
    @journeys << { entry_station: station }
  end

  def touch_out(station)
    @balance -= MIN_FARE
    @journeys.last[:exit_station] = station
  end

  def deduct(debit_amount)
    @balance -= debit_amount
  end

  private

  def insufficient_balance?
    @balance < MIN_BALANCE
  end



end
