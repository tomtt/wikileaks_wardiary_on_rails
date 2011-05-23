class InfoController < ApplicationController
  before_filter :disable_tag_cloud

  caches_page :about, :wia_kia

  def intentional_error
    if ENV['DISABLE_INTENTIONAL_ERROR']
      render(:text => "Nothing to see here, please move along...")
    else
      raise "An error was intentionally raised"
    end
  end

  def wia_kia
    @guardian_headlines = Headline.load_hash_from_json
    @guardian_headlines[Date.parse("2004-01-01")] = Headline.new("title" => "Headlines are only available from September 2005", "url" => "#month_2005-09")
  end

  private

  def disable_tag_cloud
    @show_tag_cloud = false
  end
end
