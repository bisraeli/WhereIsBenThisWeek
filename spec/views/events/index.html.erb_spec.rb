require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :external_id => "External",
        :client => "Client",
        :sequence => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :recurs => false
      ),
      stub_model(Event,
        :external_id => "External",
        :client => "Client",
        :sequence => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :recurs => false
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "External".to_s, :count => 2
    assert_select "tr>td", :text => "Client".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
