require 'spec_helper'

describe WarEventsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/war_events" }.should route_to(:controller => "war_events", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/war_events/new" }.should route_to(:controller => "war_events", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/war_events/1" }.should route_to(:controller => "war_events", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/war_events/1/edit" }.should route_to(:controller => "war_events", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/war_events" }.should route_to(:controller => "war_events", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/war_events/1" }.should route_to(:controller => "war_events", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/war_events/1" }.should route_to(:controller => "war_events", :action => "destroy", :id => "1") 
    end
  end
end
