Rails.application.routes.draw do
  root 'welcome#index'
  get '/about' => 'about#index'
  get '/terms' => 'terms#index'
  get '/faqs' => 'faqs#index'
  resources :tasks

end
