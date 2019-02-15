Rails.application.routes.draw do
  root to: 'home#index'
  post '/subscribe', to: 'notification#subscribe'
  post '/push',      to: 'notification#push'
end
