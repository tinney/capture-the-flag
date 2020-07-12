Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:index, :show]
  resources :teams do
    resources :players
  end

  resources :players, only: [:show] do
    resources :moves, only: [:create, :new]
  end

  match 'api/player' => 'api/players#show', :via => :get
  namespace 'api' do
    resources :players, only: [:create]
    resources :moves, only:   [:create]
  end

  get 'leaderboard', to: 'games#leaderboard'

  root to: 'games#index'
end
