require './lib/oystercard'
describe Oystercard do
  subject(:oystercard) {described_class.new}

  it 'should have a balance' do
    expect(oystercard).to respond_to (:balance)
  end

  it 'should be able to change the balance' do
    oystercard = Oystercard.new(10)
    expect(oystercard.balance).to eq 10
  end

end
