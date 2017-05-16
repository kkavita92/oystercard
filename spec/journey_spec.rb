require 'journey'

describe Journey do
  it { is_expected.to respond_to(:fare) }
  it { is_expected.to respond_to(:complete?) }
  it { is_expected.to respond_to(:end_journey) }

  it 'entry station should have default value of nil' do
    expect(subject.entry_station).to eq nil
  end

  it 'exit station should have default value of nil' do
    expect(subject.exit_station).to eq nil
  end

  describe '#end_journey' do

    it 'should complete the journey' do
      subject.end_journey
      expect(subject).to be_complete
    end
  end

  describe '#fare' do

    it 'should return the fare for the journey' do
      expect(subject.fare).to eq Journey::MIN_FARE
    end
  end

end
