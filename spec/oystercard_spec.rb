require 'oystercard'

describe Oystercard do

#  described_class.send(:public, described_class.private_instance_methods)

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top up balance' do
    expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
  end

  context 'it has full balance' do
    before{subject.top_up(described_class::MAXIMUM_BALANCE)}
    #it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'raise error if the maximum amount is exceeded' do
      expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end

    it 'can deduct an amount from the balance' do
      expect { subject.deduct(5) }.to change{ subject.balance }.by -5
    end

    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end


    it 'can touch in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deduct the minimum charge when touch out' do
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by(-described_class::MINIMUM_BALANCE)
    end
  end
end
