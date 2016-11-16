require './lib/journey'
describe Journey do
subject (:journey) {described_class.new}
let(:station1) {double :station1}
let(:station2) {double :station2}
let(:oystercard) {double :oystercard}

context "in_journey" do
  it "should check whether oyster is in journey" do
    expect(journey.in_journey?).to eq false
  end
end

context "touch in" do
   it "entry station should reflect the station where we registered the station" do
     journey.entry_station_registered(station1)
     expect(journey.entry_station).to eq station1
   end

   it "makes in journey true if entry station has been registered" do
     journey.entry_station_registered(station1)
     expect(journey.in_journey?).to be true
   end

 end


 context "touch out" do
    it "in journey should be false if oyster has touched out" do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      journey.reset_stations
      expect(journey.in_journey?).to eq false
    end


    it "should forget the exit station on registering it" do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      journey.reset_stations
      expect(journey.exit_station). to eq nil
    end

    it "should forget the entry station on registering the exit station" do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      journey.reset_stations
      expect(journey.entry_station). to eq nil
    end

    it 'needs to know which station I touched out at' do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      expect(journey.exit_station). to eq station2
    end

  end

  context "record journey" do
    it "checks whether there is an empty list of journeys by default" do
    expect(journey.previous_trips).to eq ([])
   end

    it "needs to create a hash to store entry and exit station" do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      journey.storing_the_journey
      expect(journey.trip).to eq({:entry => station1, :exit => station2})
    end

    it "needs to store our journey in previous trips array" do
      journey.entry_station_registered(station1)
      journey.exit_station_registered(station2)
      journey.storing_the_journey
      journey.storing_to_trips
      expect(journey.previous_trips).to eq([{:entry => station1, :exit => station2}])
    end

  end

end
