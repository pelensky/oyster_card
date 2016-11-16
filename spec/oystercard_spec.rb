require './lib/oystercard'
describe Oystercard do



  subject(:oystercard) {described_class.new}

  let(:station1) {double :station1}
  let(:station2) {double :station2}

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


  context "touch in" do

    it "should fail if oyster has less than £1" do
      oystercard.top_up(0.5)
      expect { oystercard.touch_in(station1) }.to raise_error "Not enough money for single journey"
    end


  end

  context "touch out" do


  end

  context "fare" do
    it 'should subtract minimum fare from balance after touching out' do
      oystercard.top_up(2)
      oystercard.touch_in(station1)
      expect { oystercard.touch_out(station2) }.to change{oystercard.balance}.by(-1)
    end

    it "should subtract maximum fare from balance if no touch in was recorded" do
      expect { oystercard.touch_out(station2) }.to change{oystercard.balance}.by(-6)
    end

    it "should subtract maximum far from balance if a touch in was recorded but a touch out was not" do
      #HAVE NOT DONE YET
    end
  end
end
