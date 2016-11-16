describe Station do
subject(:station) {described_class.new}

it "should initialize with a station name" do
  expect(station.name).to eq("Brixton")
end

it "should initialize with a zone number" do
  expect(station.zone).to eq(2)
end

end
