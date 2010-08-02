class DatesController < ApplicationController
  def show
    @war_events = WarEvent.on_date(Date.parse(params[:id]))
  end
end
