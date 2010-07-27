module WarEventsHelper
  def wia_kia_table(war_event)
    s = "<table class='wia_kia'>\n"
    s << "<tr><th/><th>WIA</th><th>KIA</th></tr>\n"
    types = %w{civilian host_nation friendly enemy}
    types.each do |type|
      s << "<tr><th>#{type.humanize}:</th><td>#{war_event.send(type + "_wia")}</td><td>#{war_event.send(type + "_kia")}</td></tr>\n"
    end
    s << "<tr><th colspan='3'>Enemy detained:</th><td>#{war_event.enemy_detained}</td></tr>\n"
    s << "</table>\n"
    s
  end
end
