ActionController::Routing::Routes.draw do |map|
  map.resources :war_events
  map.root :controller => "war_events", :action => "index"
end
