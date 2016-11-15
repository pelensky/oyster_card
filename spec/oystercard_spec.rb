require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:balance) {double(:amount => Oystercard::MINIMUM_BALANCE + 1, :add_amount => 20)}
  # allow(:balance).to receive(:add_amount).and_return 20
  let(:insufficient_balance) {double(:amount => Oystercard::MINIMUM_BALANCE - 1)}

  before(:each) do
    subject.balance=(balance)
  end

  describe "#balance" do

    #this doesn't work and I have no idea why

    it "can have its balance topped up" do
      oystercard.top_up(20)
      expect(oystercard.balance.amount).to eq 20
    end

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

      it "raises an error if you try to touch in with < minimum balance" do
        message = "Insufficient balance."
        subject.balance=(insufficient_balance)
        expect { oystercard.touch_in }.to raise_error(RuntimeError, message)
      end

    end

  end

end
