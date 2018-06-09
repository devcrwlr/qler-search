Rails.application.routes.draw do
  resources :song_infos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'search#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  get 'lyrics_search', to: 'search#search'
  get 'lyrics_saved', to: 'search#saved'
end
