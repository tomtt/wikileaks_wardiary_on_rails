ActionController::Routing::Routes.draw do |map|
  map.resources :term_tags do |term_tags|
    term_tags.resources :war_events
  end
  map.resources :war_events
  map.resources :dates, :only => [:show]

  map.root :controller => "war_events", :action => "index"
  map.about '/about', :controller => "info", :action => "about"
  map.stats '/stats', :controller => "info", :action => "wia_kia"
end
