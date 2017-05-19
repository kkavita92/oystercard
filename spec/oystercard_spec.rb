require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station, zone: 1 }
  let(:exit_station)  { double :station, zone: 1 }
  let(:journey) {double :journey }
  subject(:card) { described_class.new(20) }
  subject(:empty_card) { described_class.new }

  it 'should be able to test that a freshly initialized card has a balance of 0 by default' do
    expect(empty_card.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  it 'should have an empty list of journeys by default' do
    expect(card.journey_log.journeys).to be_empty
  end


  describe '#top_up' do

    it "should enable an oystercard's balance to be topped up" do
      top_up_amount = 5
      card.top_up(top_up_amount)
      expect(card.balance).to eq 25
    end

    it "should raise an error when top_up_amount would cause card's balance to exceed maximum balance" do
      expect { card.top_up(Oystercard::MAX_BALANCE) }.to raise_error(BalanceError)
    end
  end

  describe '#touch_in' do

    it 'should remember entry station after touch in at barrier' do
      card.touch_in(entry_station)
      expect(card.journey_log.current_journey.entry_station).to eq entry_station
    end

    it 'should raise an error if balance is below minimum balance' do
      expect { empty_card.touch_in(entry_station) }.to raise_error(BalanceError)
    end

     it 'should deduct PENALTY_FARE if we touch in twice' do
       card.touch_in(entry_station)
       expect{ card.touch_in(exit_station) }.to change{ card.balance }.by(-(Journey::PENALTY_FARE))
     end
  end

  describe '#touch_out' do
    before{ card.touch_in(entry_station) }

    it 'should reduce balance by journey fare' do
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-(Journey::MIN_FARE))
    end

    it 'should save exit station when card touches out' do
      card.touch_out(exit_station)
      expect(card.journey_log.journeys.last.exit_station).to eq exit_station
    end

    it 'should deduct PENALTY_FARE if we touch out twice' do
      card.touch_out(exit_station)
      expect{ card.touch_out(entry_station) }.to change{ card.balance }.by(-(Journey::PENALTY_FARE))
    end
  end


end
