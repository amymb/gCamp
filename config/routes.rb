Rails.application.routes.draw do
  root 'welcome#index'
  get '/about' => 'about#index'
  get '/terms' => 'terms#index'
  get '/faqs' => 'faqs#index'

  resources :users
  resources :projects do
    resources :memberships
    resources :tasks do
      resources :comments, only: [:create]
    end
  end
  resources :pivotal_api, only: [:show]
  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-in', to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'
  get 'sign-out', to: 'authentication#destroy'

end
