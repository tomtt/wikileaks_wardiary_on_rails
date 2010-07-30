class InfoController < ApplicationController
  before_filter :disable_tag_cloud

  private

  def disable_tag_cloud
    @show_tag_cloud = false
  end
end
