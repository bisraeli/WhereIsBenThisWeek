require 'spec_helper'

describe EventImporter do
  let(:location) {
    [
      double('location').tap do |l|
        l.stub(:latitude) { latitude}
        l.stub(:longitude) { longitude }
      end
    ]
  }
  let(:latitude){ 40.94332 }
  let(:longitude){ 29.3242 }
  let(:address) { "Top of Pennsylvania Avenue"}
  let(:time) {Time.now}
  let(:id) { "adsfadsf323"}
  let(:summary) { "John Appleseed" }
  let(:sequence) { "1"}
  let(:event_definition) {
    {
      :latitude => latitude,
      :longitude => longitude,
      :start_time => time,
      :end_time => time,
      :recurs => false,
      :sequence => sequence,
      :client => summary,
      :external_id => id
    }
  }
  let(:google_event) {
    {
      "location" => address,
      "start" => {"dateTime" => time},
      "end" => {"dateTime" => time},
      "summary" => summary,
      "sequence" => sequence,
      "id" => id
    }
  }
  it "creates an event" do
    Event.should_receive(:create!).with(event_definition)

    Geocoder.should_receive(:search).with(address) { location }

    subject.create_event(google_event)
  end

  it "creates a recurring event" do
    Event.should_receive(:create!).with(event_definition.tap{ |definition|
      definition[:recurs] = true
    })

    Geocoder.should_receive(:search).with(address) { location }

    subject.create_event(google_event, true)
  end
end
