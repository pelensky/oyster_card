require 'balance'

describe Balance do
  subject(:balance) { described_class.new }

  describe 'adding to and deducting from amount' do

    it "initializes with a amount of 0" do
      expect(balance.amount).to eq(0)
    end

    it "can have its amount added to" do
      balance.add_amount(20)
      expect(balance.amount).to eq 20
    end

    it "can have its balance deducted" do
      balance.add_amount(20)
      balance.deduct_amount(15)
      expect(balance.amount).to eq 5
    end

  end

end
