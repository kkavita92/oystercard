require 'journey'

describe Journey do
  it { is_expected.to respond_to(:fare) }
  it { is_expected.to respond_to(:complete?) }

  it 'entry station should have default value of nil' do
    expect(subject.entry_station).to eq nil 
  end
end
