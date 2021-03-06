class WarEventsController < ApplicationController
  resources_controller_for :war_events, :only => [:index, :show]

  caches_page :index, :show

  def index
    super
  end

  def show
    begin
      super
    rescue ActiveRecord::RecordNotFound
      render_404 and return
    end
    @page_title = "War Event: #{@war_event.title}"
    @term_list = @war_event.term_list
    @tags = @term_list.map { |t| ActsAsTaggableOn::Tag.find_by_name(t) }
    @term_definitions = @term_list.map { |t| TermDefinition.find_by_term(t) }
  end

  def find_resources
    resource_service.paginate :page => params[:page], :order => 'date DESC'
  end

  def find_resource
    WarEvent.find_by_report_key!(params[:id])
  end
end
