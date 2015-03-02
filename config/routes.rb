Rails.application.routes.draw do
  root 'welcome#index'
  get '/about' => 'about#index'
  get '/terms' => 'terms#index'
  get '/faqs' => 'faqs#index'
  resources :tasks
  resources :users
  resources :projects
  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-in', to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'
  get 'sign-out', to: 'authentication#destroy'

end
