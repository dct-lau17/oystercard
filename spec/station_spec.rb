require 'station'
describe Station do
  let(:station) { Station.new('Liverpool Street', 1) }

  it 'should take name on creation' do
    expect(station.name).to eq 'Liverpool Street'
  end
  it 'should take zone on creation' do
    expect(station.zone).to eq 1
  end
end
