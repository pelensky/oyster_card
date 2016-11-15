require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "initializes with a balance of 0" do
    expect(oystercard.balance).to eq(0)
  end

  it "can have its balance updated" do
    oystercard.top_up(20)
    expect(oystercard.balance).to eq 20
  end

  it "will raise an error if the user tops up with a negative number" do
    message = "You can't top up with a negative number."
    expect{oystercard.top_up(-5)}.to raise_error(RuntimeError, message)
  end
end
