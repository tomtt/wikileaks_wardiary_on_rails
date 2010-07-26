class WarEventsController < ApplicationController
  # GET /war_events
  # GET /war_events.xml
  def index
    @war_events = WarEvent.all(:limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @war_events }
    end
  end

  # GET /war_events/1
  # GET /war_events/1.xml
  def show
    @war_event = WarEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @war_event }
    end
  end
end
