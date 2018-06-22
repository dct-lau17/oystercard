require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {double :journey}

  Oystercard.send(:public, :deduct)

  describe "defaults" do

    it 'has a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end

    it 'has an empty list of journeys' do
      expect(oystercard.history).to be_empty
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
      expect { oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end
  end

  context 'it has full balance' do
    let(:journey){ {entry_station: entry_station, exit_station: exit_station } }
    before do
      oystercard.top_up(described_class::MAXIMUM_BALANCE)
    end

    it { is_expected.to respond_to(:deduct).with(1).argument }

    describe '#touch_in' do

      it { is_expected.to respond_to(:touch_in).with(1).argument }

       # it 'stores journey information' do
       #   oystercard.touch_in(entry_station)
       #   oystercard.touch_out(exit_station)
       #   expect(oystercard.journeys).to include journey
       # end
      # it 'accepts the entry station when touch in' do
      #   oystercard.touch_in(entry_station)
      #   expect(oystercard.entry_station).to eq entry_station
      #   end
    end

    it 'can deduct an amount from the balance' do
      expect { oystercard.deduct(5) }.to change{ oystercard.balance }.by(-5)
    end

     it { is_expected.to respond_to(:touch_out).with(1).argument }

    # it 'forgets entry_station' do
    #   oystercard.touch_in(entry_station)
    #   oystercard.touch_out(exit_station)
    #   expect(oystercard.entry_station).to eq nil
    # end

    # it 'deduct the minimum charge when touch out' do
    #   expect { oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-described_class::MINIMUM_BALANCE)
    # end
  end
end
