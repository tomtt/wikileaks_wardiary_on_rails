class TermTagsController < ApplicationController
  resources_controller_for :term_tags, :class => ActsAsTaggableOn::Tag
end
