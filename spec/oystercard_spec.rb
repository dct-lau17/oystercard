require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new}
  let(:station) {double :station}

  Oystercard.send(:public, :deduct)

  describe "defaults" do
    it 'has a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end

    it 'is initially not in journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up balance' do
      expect { oystercard.top_up(1) }.to change{ oystercard.balance }.by 1
    end
  end

  context 'it has low balance' do
    it 'will not touch in if below minimum balance' do
      expect { oystercard.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end
  end


  context 'it has full balance' do

    before do
      oystercard.top_up(described_class::MAXIMUM_BALANCE)
    end
    # it { is_expected.to respond_to(:deduct).with(1).argument }
    describe '#touch_in' do
      it 'can touch in' do
        oystercard.touch_in(station)
        expect(oystercard).to be_in_journey
      end

      it 'accepts the entry station when touch in' do
        oystercard.touch_in(station)
        expect(oystercard.entry_station).to eq station
        end
    end

    it 'raises error if the maximum amount is exceeded' do
      expect{ oystercard.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end

    it 'can deduct an amount from the balance' do
      expect { oystercard.deduct(5) }.to change{ oystercard.balance }.by(-5)
    end

    it 'can touch out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'forgets entry_station' do
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end

    it 'deduct the minimum charge when touch out' do
      expect { oystercard.touch_out }.to change{ oystercard.balance }.by(-described_class::MINIMUM_BALANCE)
    end

  end
end
