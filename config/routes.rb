Rails.application.routes.draw do
  get 'event/events'
  mount GoodJob::Engine => 'good_job'
  
  namespace :api do
    namespace :v1 do
      resources :events, only: [:index]
    end
  end
end
