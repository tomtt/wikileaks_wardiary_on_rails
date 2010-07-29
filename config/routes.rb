ActionController::Routing::Routes.draw do |map|
  map.resources :term_tags do |term_tags|
    term_tags.resources :war_events
  end
  map.resources :war_events
  map.root :controller => "war_events", :action => "index"
end
