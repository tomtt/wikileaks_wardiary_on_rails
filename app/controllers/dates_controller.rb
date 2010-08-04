class DatesController < ApplicationController
  def show
    begin
      @date = Date.parse(params[:id])
    rescue ArgumentError
      render_404 and return
    end

    @page_title = "War events on #{@date.to_s(:concise)}"

    @war_events = WarEvent.on_date(@date).paginate(:page => params[:page], :order => 'date ASC')
  end
end
