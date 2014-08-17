OmniMulti::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations", omniauth_callbacks: "omniauth_callbacks" }
  get 'new_authorization', to: 'welcome#new_auth'
  resources :accounts
  root 'welcome#index'
  get 'pricing', to: 'welcome#pricing'
end
