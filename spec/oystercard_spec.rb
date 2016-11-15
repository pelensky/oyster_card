require './lib/oystercard'
require './lib/station'
describe Oystercard do

  let(:station1) {double :station1}

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

   it 'fails to top up if balance will be greater than 90' do
     oystercard.top_up(89)
     expect { oystercard.top_up(2) }.to raise_error 'oystercard has maximum limit of £90'
   end
 end

 context "deducting a fare" do
   it "should update balance after deducting a fare" do
     oystercard.top_up(50)
     oystercard.touch_out
     expect(oystercard.balance).to eq 49
   end
 end

 context "in_journey" do
   it "should check whether oyster is in journey" do
     expect(oystercard.in_journey?).to eq false
   end
 end

context "touch in" do
   it "in journey should be true if oyster has touched in" do
     oystercard.top_up(3)
     oystercard.touch_in(@station1)
     expect(oystercard.entry_station).to eq @station1
   end

   it "should fail if oyster has less than £1" do
     oystercard.top_up(0.5)
     expect { oystercard.touch_in(@station1) }.to raise_error "Not enough money for single journey"
   end

   it "needs to know where I've travelled" do
     oystercard.top_up(5)
     oystercard.touch_in(@station1)
     expect(oystercard.entry_station).to eq @station1
   end

end

context "touch out" do
   it "in journey should be false if oyster has touched out" do
     oystercard.top_up(2)
     oystercard.touch_in(@station1)
     oystercard.touch_out
     expect(oystercard.in_journey?).to eq false
   end

   it 'should subtract minimum fare from balance after checking out' do
     oystercard.top_up(2)
     oystercard.touch_in(@station1)
     expect { oystercard.touch_out }.to change{oystercard.balance}.by(-1)
   end

   it 'should forget the entry station on touch out' do
     oystercard.top_up(2)
     oystercard.touch_in(@station1)
     oystercard.touch_out
     expect(oystercard.entry_station). to eq nil
   end
end

end
