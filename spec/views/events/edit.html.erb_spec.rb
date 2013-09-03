require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :external_id => "MyString",
      :client => "MyString",
      :sequence => 1,
      :latitude => 1.5,
      :longitude => 1.5,
      :recurs => false
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select "input#event_external_id[name=?]", "event[external_id]"
      assert_select "input#event_client[name=?]", "event[client]"
      assert_select "input#event_sequence[name=?]", "event[sequence]"
      assert_select "input#event_latitude[name=?]", "event[latitude]"
      assert_select "input#event_longitude[name=?]", "event[longitude]"
      assert_select "input#event_recurs[name=?]", "event[recurs]"
    end
  end
end
