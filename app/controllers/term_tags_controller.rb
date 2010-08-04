class TermTagsController < ApplicationController
  resources_controller_for :term_tags, :class => ActsAsTaggableOn::Tag, :only => [:index, :show]

  caches_page :index, :show

  def show
    begin
      super
    rescue ActiveRecord::RecordNotFound
      render_404 and return
    end
    @page_title = "War events tagged with \"#{@term_tag.name}\""

    @definition = TermDefinition.find_by_term(@term_tag.name).definition
    @war_events = WarEvent.tagged_with(@term_tag.name).paginate(:page => params[:page], :order => 'date DESC')
  end

  def find_resources
    resource_service.all(:order => :name)
  end
end
