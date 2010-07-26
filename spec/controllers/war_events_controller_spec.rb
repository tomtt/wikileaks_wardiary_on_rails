require 'spec_helper'

describe WarEventsController do

  def mock_war_event(stubs={})
    @mock_war_event ||= mock_model(WarEvent, stubs)
  end

  describe "GET index" do
    it "assigns all war_events as @war_events" do
      WarEvent.stub(:find).with(:all).and_return([mock_war_event])
      get :index
      assigns[:war_events].should == [mock_war_event]
    end
  end

  describe "GET show" do
    it "assigns the requested war_event as @war_event" do
      WarEvent.stub(:find).with("37").and_return(mock_war_event)
      get :show, :id => "37"
      assigns[:war_event].should equal(mock_war_event)
    end
  end

  describe "GET new" do
    it "assigns a new war_event as @war_event" do
      WarEvent.stub(:new).and_return(mock_war_event)
      get :new
      assigns[:war_event].should equal(mock_war_event)
    end
  end

  describe "GET edit" do
    it "assigns the requested war_event as @war_event" do
      WarEvent.stub(:find).with("37").and_return(mock_war_event)
      get :edit, :id => "37"
      assigns[:war_event].should equal(mock_war_event)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created war_event as @war_event" do
        WarEvent.stub(:new).with({'these' => 'params'}).and_return(mock_war_event(:save => true))
        post :create, :war_event => {:these => 'params'}
        assigns[:war_event].should equal(mock_war_event)
      end

      it "redirects to the created war_event" do
        WarEvent.stub(:new).and_return(mock_war_event(:save => true))
        post :create, :war_event => {}
        response.should redirect_to(war_event_url(mock_war_event))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved war_event as @war_event" do
        WarEvent.stub(:new).with({'these' => 'params'}).and_return(mock_war_event(:save => false))
        post :create, :war_event => {:these => 'params'}
        assigns[:war_event].should equal(mock_war_event)
      end

      it "re-renders the 'new' template" do
        WarEvent.stub(:new).and_return(mock_war_event(:save => false))
        post :create, :war_event => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested war_event" do
        WarEvent.should_receive(:find).with("37").and_return(mock_war_event)
        mock_war_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :war_event => {:these => 'params'}
      end

      it "assigns the requested war_event as @war_event" do
        WarEvent.stub(:find).and_return(mock_war_event(:update_attributes => true))
        put :update, :id => "1"
        assigns[:war_event].should equal(mock_war_event)
      end

      it "redirects to the war_event" do
        WarEvent.stub(:find).and_return(mock_war_event(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(war_event_url(mock_war_event))
      end
    end

    describe "with invalid params" do
      it "updates the requested war_event" do
        WarEvent.should_receive(:find).with("37").and_return(mock_war_event)
        mock_war_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :war_event => {:these => 'params'}
      end

      it "assigns the war_event as @war_event" do
        WarEvent.stub(:find).and_return(mock_war_event(:update_attributes => false))
        put :update, :id => "1"
        assigns[:war_event].should equal(mock_war_event)
      end

      it "re-renders the 'edit' template" do
        WarEvent.stub(:find).and_return(mock_war_event(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested war_event" do
      WarEvent.should_receive(:find).with("37").and_return(mock_war_event)
      mock_war_event.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the war_events list" do
      WarEvent.stub(:find).and_return(mock_war_event(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(war_events_url)
    end
  end

end
