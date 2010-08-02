class DatesController < ApplicationController
  def show
    @date = Date.parse(params[:id])
    @war_events = WarEvent.on_date(@date).paginate(:page => params[:page], :order => 'date DESC')
  end
end
