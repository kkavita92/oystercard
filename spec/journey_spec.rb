require 'journey'

describe Journey do
  let (:station) {double :station, zone: 1}
  let (:station2) {double :station, zone: 2}

  # describe '#end_journey' do
  #   it 'should complete the journey' do
  #     subject.end_journey
  #     expect(subject).to be_complete
  #   end
  # end

  describe '#fare' do
    subject {described_class.new(station)}

    it 'should return the fare for the journey if touched in/out' do
      journey = Journey.new(station)
      journey.end_journey(station2)
      expect(journey.fare).to eq 2
    end
  end

  context 'if no touch out' do
    subject {described_class.new(station)}

    it 'exit station should have default value of nil' do
      expect(subject.exit_station).to eq nil
    end

    it'should return penalty fare if no touch out' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  context 'if no touch in' do
    it 'entry station should have default value of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'should return penalty fare if no touch in' do
      subject.end_journey(station2)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end



end
