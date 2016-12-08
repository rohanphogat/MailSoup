Rails.application.routes.draw do
  root 'users#activate'
  resources :users, only: [:index,:new,:create] do
  end
  post '/mailgun/webhooks', :to => 'mailgun#webhook_stats'
end
