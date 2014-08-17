OmniMulti::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :accounts
  root 'welcome#index'
  get 'pricing', to: 'welcome#pricing'
end
