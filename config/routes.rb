ActionController::Routing::Routes.draw do |map|
  map.resources :term_tags
  map.resources :war_events
  map.root :controller => "war_events", :action => "index"
end
