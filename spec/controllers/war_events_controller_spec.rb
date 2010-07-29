require 'spec_helper'

describe WarEventsController do

  def mock_war_event(stubs={})
    @mock_war_event ||= mock_model(WarEvent, stubs)
  end

  describe "GET index" do
    it "assigns all war_events as @war_events" do
      WarEvent.stub(:find).with(:all, anything).and_return([mock_war_event])
      get :index
      assigns[:war_events].should == [mock_war_event]
    end

    it "paginates using the :page param" do
      WarEvent.should_receive(:paginate).with(hash_including(:page => "3"))
      get :index, :page => 3
    end

    it "paginates ordered by date most recent first" do
      WarEvent.should_receive(:paginate).with(hash_including(:order => 'date DESC'))
      get :index, :page => 3
    end
  end

  describe "GET show" do
    it "assigns the requested war_event as @war_event" do
      pending
      WarEvent.stub(:find_by_report_key).with("99AA5C2F-2129-4200-AB73-AA29D94E0D83").and_return(mock_war_event, :term_list => [])
      get :show, :id => "99AA5C2F-2129-4200-AB73-AA29D94E0D83"
      assigns[:war_event].should equal(mock_war_event)
    end
  end
end
