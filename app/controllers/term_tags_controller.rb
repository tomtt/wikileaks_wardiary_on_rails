class TermTagsController < ApplicationController
  resources_controller_for :term_tags, :class => ActsAsTaggableOn::Tag

  def show
    @term_tag = resource_service.find(params[:id])
    @war_events = WarEvent.tagged_with(@term_tag.name).paginate(:page => params[:page], :order => 'date DESC')
  end

  def find_resources
    resource_service.all(:order => :name)
  end
end