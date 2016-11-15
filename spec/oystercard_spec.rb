require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "initializes with a balance of 0" do
    expect(oystercard.balance).to eq(0)
  end

  it "can have its balance topped up" do
    oystercard.top_up(20)
    expect(oystercard.balance).to eq 20
  end

  it "can have its balance deducted" do
    oystercard.top_up(20)
    oystercard.deduct_fare(15)
    expect(oystercard.balance).to eq 5
  end

  describe 'error handling' do

    describe 'topping up' do

      it "will raise an error if the user tops up with a negative number" do
        message = "You can't top up with a negative number."
        expect{oystercard.top_up(-5)}.to raise_error(RuntimeError, message)
      end

      it 'raises an error if you try to top up 0' do
        message = "You can't top up 0."
        expect{ oystercard.top_up(0) }.to raise_error(RuntimeError, message)
      end

      it "raises an error if you try to top up too much" do
        maximum_top_up = Oystercard::MAXIMUM_TOP_UP
        message = "You can top up a maximum of #{maximum_top_up}."
        expect {oystercard.top_up(maximum_top_up + 1)}.to raise_error(RuntimeError, message)
      end

      it 'raises an error if you try to top up a number with >2 decimal places' do
        message = 'You can only top up numbers with a max. of 2 decimal places'
        expect { oystercard.top_up(1.111) }.to raise_error(RuntimeError, message)
      end

    end

    describe 'deducting' do

      it "raises an error if you try to deduct a negative number" do
        message = "You can not deduct a negative number."
        expect {oystercard.deduct_fare(-1)}.to raise_error(RuntimeError, message)
      end

      it "raises an error if you try to deuct 0" do
        message = "You can not deduct 0."
        expect {oystercard.deduct_fare(0)}.to raise_error(RuntimeError, message)
      end

      it 'raises an error if you try to deduct a number with >2 decimal places' do
        message = "You can only deduct numbers with a max. of 2 decimal places"
        expect { oystercard.deduct_fare(1.1111) }.to raise_error(RuntimeError, message)
      end

    end

  end
end
