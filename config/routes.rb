Rails.application.routes.draw do
  namespace :reports do
    match 'conferences/:conference_id/attendees' => 'conferences#attendees', via: :get
    match 'events/:event_id/speakers' => 'events#speakers', via: :get
  end

  # handle common error conditions in an appropriate, API friendly way
  match '/errors/internal' => 'errors#internal', via: :all
  match '/errors/route' => 'errors#not_implemented', via: :all
  match '/404*' => 'errors#not_implemented', via: :all
  match '/500*' => 'errors#internal', via: :all

  # prevent route does not exist errors
  match '*path', to: 'errors#not_implemented', via: :all
  match '*unmatched_route', to: 'errors#not_implemented', via: :all

  root to: 'application#root'
end
