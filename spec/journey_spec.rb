require 'journey'

describe Journey do
  describe '#defaults' do
    let(:journey) {Journey.new}
    it 'the journey is not complete' do
      expect(journey).not_to be_complete
    end

  end

  context 'no entry_station given' do
    let(:journey) {Journey.new}
    let(:exit_station) { double(:station) }
    let(:entry_station){ double(:station) }

    it "sets entry_station to nil as default" do
      expect(journey.entry_station).to eq nil
    end

    it 'has an exit station' do
      journey.exit(exit_station)
      expect(journey.exit_station).to eq exit_station
    end

    it 'does not complete the journey' do
      journey.exit(exit_station)
      expect(journey).to be_complete
    end

    it 'penalty is set to true' do
      journey.exit(exit_station)
      expect(journey.penalty?).to eq true
    end
  end

  context 'entry_station given' do
    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }
    let(:journey) { Journey.new(entry_station) }

    it 'returns entry station when created' do
      expect(journey.entry_station).to eq entry_station
    end

    it 'completes a journey' do
      journey.exit(exit_station)
      expect(journey).to be_complete
    end

    it 'returns minimum fare' do
      journey.exit(exit_station)
      expect(journey.fare).to eq described_class:: MINIMUM_FARE
    end


    context 'no exit station provided' do
      it 'returns nil' do
        journey.exit
        expect(journey.exit_station).to eq nil
      end

      it 'penalty is set to true' do
        journey.exit
        expect(journey.penalty?).to eq true
      end

      it 'returns penalty fare' do
        journey.exit
        expect(journey.fare).to eq described_class::PENALTY_FARE
      end
    end
  end
end
