require 'spec_helper'

describe DatesController do

  describe "show" do
    before do
      Date.stub!(:parse)
      WarEvent.stub!(:on_date)
    end

    it "parses the id as a date" do
      Date.should_receive(:parse).with('2008-03-21')
      get :show, :id => '2008-03-21'
    end

    it "finds the events by the date returned by parsing the id param" do
      some_date = Date.parse('2005-06-06')
      Date.stub!(:parse).and_return(some_date)
      WarEvent.should_receive(:on_date).with(some_date)
      get :show, :id => '2008-03-21'
    end

    it "assigns the war_events to @war_events" do
      mock_war_event = mock('war event')
      WarEvent.stub!(:on_date).and_return([mock_war_event])
      get :show, :id => '2008-03-21'
      assigns[:war_events].should == [mock_war_event]
    end
  end

end
