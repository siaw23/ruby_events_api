Rails.application.routes.draw do
  mount GoodJob::Engine => 'good_job'
  
  namespace :api do
    namespace :v1 do
      resources :events, only: [:index], as: "upcoming_events"
    end
  end
end
