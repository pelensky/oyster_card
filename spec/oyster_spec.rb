require 'oyster'


describe Oyster do
  subject(:card) {described_class.new}
  let(:station) {double(:station)}
  let(:station2) {double(:station)}

  describe "Balance" do
    it "should display zero when object is initialized" do
      expect(card.balance).to eq 0
    end

    context "when the balance exceeds its limits, should raise an error" do

      it "if there less balance then minimum journey fare, and we touch in" do
        card.top_up(0.5)
        message = "You're poor, go and top up"
        expect{card.touch_in(station)}.to raise_error(message)
      end

      it " if we add more than 90 to the balance" do
        message = "The limit for topping up is 90 pounds"
        expect{card.top_up(91)}.to raise_error(message)
      end



    end
  end

  describe "will change, " do
    before(:each) {card.top_up(10)}
    it "should add 10 to the balance" do
      expect(card.balance).to eq 10
    end
  end

  describe "When checking card status" do
    before(:each) {card.top_up(10)}
    it "should return nil as a default" do
      expect(card.entry_station).to eq nil
    end

    it "should deduct minimum fare from the balance when checking out" do
      card.touch_in(station)
      expect{card.touch_out(station)}.to change{card.balance}.by(-1)
    end

  end

  describe "To keep history of journeys" do
    before(:each) {card.top_up(10)}

    it "should take station as a variable when touching in" do
      expect(card).to respond_to(:touch_in).with(1).argument
    end



    it 'should save the journey history' do
      expect(card).to respond_to(:journey_history)
    end
  end



  context "using Journey" do


    it "saves each journey" do
      card.top_up(10)
      card.touch_in("station1")
      card.touch_out("station2")
      expect(card.journey_history).to eq [{:entry_station=>"station1", :exit_station=>"station2"}]
    end
  end

  context "when the journey is not complete" do
    before(:each) {card.top_up(15)}
    it "charges a penalty fare when there is no touch in" do
      card.touch_out("station2")
      expect(card.balance).to eq 9
    end

    it "charges a penalty fare when there is no touch out" do
      card.touch_in("station1")
      card.touch_in("station2")
      expect(card.balance).to eq 4
    end


  end
end
