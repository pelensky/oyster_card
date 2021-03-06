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


    # it "saves the entry station as a value in a hash trip" do
    #   journey.save_entry("old street")
    #   journey.start_journey
    #   expect(journey.trip[:entry_station]).to eq "old street"
    # end

    it "saves the exit station as a value in the hash trip" do
      journey.save_exit("bank")
      journey.end_journey
      expect(journey.trip[:exit_station]).to eq "bank"
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
      expect(journey.trip).to eq({entry_station: nil, exit_station: nil})
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

  context "when calculating the cost of a journey" do

    it "returns the minimum fare if journey is complete" do
      journey.save_entry("station1")
      journey.start_journey
      journey.save_exit("station2")
      journey.end_journey
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "returns penalty fare if trip is not complete" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns penalty fare if trip is not complete, touch in, but no touch out" do
      journey.save_entry("station1")
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns penalty fare if trip is not complete, touch out, but no touch in" do
      journey.save_exit("station1")
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end


  end
  context "journey complete" do
    it "checks that a journey is not complete by default" do
      expect(journey.complete?).to eq false
    end

    it "checks if a journey is partly complete" do
      expect(journey.partly_complete?).to eq false
    end

    it "checks that a journey is complete if entry station and exit stations are not nil" do
      journey.save_entry("station1")
      journey.start_journey
      journey.save_exit("station2")
      journey.end_journey
      expect(journey.complete?).to eq true
    end
  end

end
