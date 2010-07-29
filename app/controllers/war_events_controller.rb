class WarEventsController < ApplicationController
  # GET /war_events
  # GET /war_events.xml
  def index
    @war_events = WarEvent.paginate :page => params[:page], :order => 'date DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @war_events }
    end
  end

  # GET /war_events/1
  # GET /war_events/1.xml
  def show
    @war_event = WarEvent.find_by_report_key(params[:id])
    @term_list = @war_event.term_list
    @tags = @term_list.map { |t| ActsAsTaggableOn::Tag.find_by_name(t) }
    @term_definitions = @term_list.map { |t| TermDefinition.find_by_term(t) }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @war_event }
    end
  end
end
