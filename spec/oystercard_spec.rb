require './lib/oystercard'
describe Oystercard do
  subject(:oystercard) {described_class.new}

  context "balance" do
  it 'should have a balance' do
    expect(oystercard).to respond_to (:balance)
  end

  it 'should be able to change the balance' do
    oystercard = Oystercard.new(10)
    expect(oystercard.balance).to eq 10
  end
  end

 context "top up" do
   it "should top up the balance" do
     oystercard.top_up(10)
     expect(oystercard.balance).to eq 10
   end 
 end

end
