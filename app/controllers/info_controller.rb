class InfoController < ApplicationController
  before_filter :disable_tag_cloud

  caches_page :about, :wia_kia

  def intentional_error
    raise "An error was intentionally raised"
  end

  private

  def disable_tag_cloud
    @show_tag_cloud = false
  end
end
