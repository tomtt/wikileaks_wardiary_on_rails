class InfoController < ApplicationController
  before_filter :disable_tag_cloud

  caches_page :about, :wia_kia

  private

  def disable_tag_cloud
    @show_tag_cloud = false
  end
end
