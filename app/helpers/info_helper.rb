module InfoHelper
  def guardian_headline_for_day(day)
    data = @guardian_headlines[Date.parse(day)]
    if data
      return link_to(data.title, data.url)
    end
  end
end
