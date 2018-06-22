require 'journey_log'

describe JourneyLog do
  let(:journey_log) { JourneyLog.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  let(:journey_class) { double :journey_class, new: journey }
  subject { described_class.new(journey_class) }

  describe 'default' do
    it 'starts with an empty journeys array' do
      expect(journey_log.journeys).to be_empty
    end

    describe '#current_journey' do
      it 'should start with nil values for the entry and exit keys' do
        expect(journey_log.current_journey).to eq(entry: nil, exit: nil)
      end
    end
  end

  describe '#start' do
      JourneyLog.send(:public, :current_journey)
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(entry_station)
      subject.start(entry_station)
    end
  end

  describe '#current_journey' do
    it 'should store the entry station in a hash' do
      journey_log.start(entry_station)
      expect(journey_log.current_journey).to eq(entry: entry_station, exit: nil)
    end
    it 'should store the exit station in a hash' do
      journey_log.finish(exit_station)
      expect(journey_log.current_journey).to eq(entry: nil, exit: exit_station)
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }
  end

  describe '#store_journey' do
    it'stores the complete journey in an array' do
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.journeys).to include(entry: entry_station, exit: exit_station)
    end
  end

  describe '#fare' do
    it 'deducts minimum fare' do
      allow(journey_class).to receive(:fare) {MINIMUM_FARE}
      journey_log.start(entry_station)
      expect(journey_log.finish(exit_station)).to eq Journey::MINIMUM_FARE
    end

    it 'deducts penalty fare'do
  end

  end
end
