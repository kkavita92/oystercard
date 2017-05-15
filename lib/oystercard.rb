class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station, :list_of_journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 4

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @list_of_journeys = []
  end

  def top_up(topup_amount)
    raise(BalanceError, 'requested top-up amount exceeds limit!') if (@balance + topup_amount) > MAX_BALANCE
    @balance += topup_amount
  end

  def touch_in(entry_station)
    raise(BalanceError, 'balance is too low') if insufficient_balance?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @balance -= MIN_FARE
    @entry_station = nil
  end

  def deduct(debit_amount)
    @balance -= debit_amount
  end

  private

  def insufficient_balance?
    @balance < MIN_BALANCE
  end



end
