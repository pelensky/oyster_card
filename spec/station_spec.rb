require 'station'

describe Station do
subject(:station) {described_class.new}

context "when initializing the class" do
  it "responds to name" do
    expect(station).to respond_to(:name)
  end

  it "responds to the zone" do
    expect(station).to respond_to(:zone)

  end
end
end
