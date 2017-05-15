class BalanceError < StandardError; end

class Oystercard
  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(top_up_amount)
    raise(BalanceError, 'requested top-up amount exceeds limit!') if (@balance + top_up_amount) > MAX_BALANCE
    @balance += top_up_amount
  end

  def deduct(debit_amount)
    @balance -= debit_amount
  end

  def touch_in(entry_station)
    raise(BalanceError, 'balance is too low') if @balance < MIN_BALANCE
    @entry_station = entry_station
  end

end
