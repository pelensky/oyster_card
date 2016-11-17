require 'journey'

describe Journey do
subject(:journey) {described_class.new}



let(:oyster) {double(:oyster)}

before(:each) { allow(oyster).to receive(:touch_in) {"station1"}}
before(:each) { allow(oyster).to receive(:touch_out) {"station2"}}

  context "To keep history of journeys" do


    it "assigns the station to entry station" do
      journey.save_entry("station1")
      expect(journey.entry_station).to eq "station1"
    end

    it "assigns the station to exit station" do
      journey.save_exit("station2")
      expect(journey.exit_station).to eq "station2"
    end

    it "both entry and exit stations are saved as a hash complete journey" do
      journey.save_entry("station1")
      journey.save_exit("station2")
      journey.save_journey
      expect(journey.complete_journey).to eq({"station1"=>"station2"})
    end
end

  context "when beginning the journey" do


    it "the entry station is nil by default" do

      expect(journey.entry_station).to eq nil
    end




    it "the exit station is nil by default" do
      expect(journey.exit_station).to eq nil
    end

    it "the complete hash is empty by default" do
      expect(journey.complete_journey).to be_empty
    end
  end

  context "When ending the journey" do

    it "erase the entry station" do
      journey.save_entry("station1")
      journey.reset
      expect(journey.entry_station).to eq nil
    end

    it "erase the exit station" do
      journey.save_exit("station2")
      journey.reset
      expect(journey.exit_station).to eq nil
    end

    it "journey responds to reset journey" do
      expect(journey).to respond_to(:reset)
    end
  end

end
