require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end
    it 'raise error if the maximum amount is exceeded' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct an amount from the balance' do
      subject.top_up(20)
      expect { subject.deduct(5) }.to change{ subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
