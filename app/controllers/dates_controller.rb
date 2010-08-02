class DatesController < ApplicationController
  def show
    @date = Date.parse(params[:id])
    @page_title = "War events on #{@date.to_s(:concise)}"

    @war_events = WarEvent.on_date(@date).paginate(:page => params[:page], :order => 'date ASC')
  end
end
