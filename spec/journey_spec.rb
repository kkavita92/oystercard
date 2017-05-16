require 'journey'

describe Journey do
  it { is_expected.to respond_to(:fare) }
  it { is_expected.to respond_to(:complete?) }
  
end
