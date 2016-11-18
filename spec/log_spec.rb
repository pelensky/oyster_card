require 'log'

describe Log do

subject(:log) {described_class.new}

let(:journey) {double(:journey)}

before(:each) { allow(journey).to receive(:save_entry).with("station1") {"station1"}}
before(:each) { allow(journey).to receive(:touch_out) {"station2"}}


let(:station) {double(:station)}
let(:station2) {double(:station)}

  context "to record entry and exit stations of current journey" do

    # it "saves the entry station as a value in a hash trip" do
    #   journey.save_entry("station1")
    #   log.start_journey
    #   expect(log.trip[:entry_station]).to eq "station1"
    # end


  end



end
