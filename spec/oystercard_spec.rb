require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe "#balance" do

    it "initializes with a balance" do
      expect(oystercard.balance).to be_kind_of Balance
    end

    it "can have its balance topped up" do
      oystercard.top_up(20)
      expect(oystercard.balance.amount).to eq 20
    end

  #   it "can have its balance deducted" do
  #    oystercard.top_up(20)
  #    oystercard.deduct_fare(15)
  #    expect(oystercard.balance.amount).to eq 5
  #  end

  end

  describe "touching in and out" do

    it "initializes with a touched in value of false" do
      expect(oystercard.touch_in?).to be false
    end

    it "returns true when it is touched in" do
      oystercard.touch_in
      expect(oystercard.touch_in?).to be true
    end

    it "returns false when it is not touched in" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.touch_in?).to be false
    end

  end

  describe 'error handling' do

    describe 'topping up' do

      it "will raise an error if the user tops up with a negative number" do
        message = "You can't top up with a negative number."
        expect{oystercard.top_up(-5)}.to raise_error(message)
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

      it "raises an error if you do not pass in a number" do
        message = "You can only top up a number."
        expect { oystercard.top_up("String") }.to raise_error(RuntimeError, message)
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

      it "raises an error if you do not pass in a number" do
        message = "You can only deduct a number."
        expect { oystercard.deduct_fare("String") }.to raise_error(RuntimeError, message)
      end

    end

    describe "touching in and out" do
      it "raises an error if you try to touch in a card that is already touched in" do
        message = "Error. That card is already touched in."
        oystercard.touch_in
        expect { oystercard.touch_in }.to raise_error(RuntimeError, message)
      end

      it "raises an error if you try to touch out a card that is not touched in" do
        message = "Error. That card is touched out."
        expect { oystercard.touch_out }.to raise_error(RuntimeError, message)
      end


    end

  end
end
