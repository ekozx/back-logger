Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #TODO: Refactor these with better namespaces
  # You can have the root of your site routed with "root"
  root 'backlog#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'backlog/unbuilt'      => 'backlog#unbuilt'
  get 'search'               => 'search#index'
  get 'search/:type/:query/:t'  => 'search#query'
  get 'search/reindex'       => 'search#reindex'
  get 'entries/remove/:id'   => 'entries#delete'
  get 'entries/add/:id'      => 'entries#add'
  get '/entries/'            => 'entries#new'
  # get 'users/edit'           => 'users#edit'
  get 'users/followers'      => 'users#followers'
  get 'users/following'      => 'users#following'
  get 'users/follow/:id'     => 'users#follow'
  get 'users/unfollow/:id'   => 'users#unfollow'
  get '/zaps/created'        => 'zaps#created'

  resources :entries
  resources :associations
  resources :relationships, only: [:create, :destroy]
  resources :zaps
  devise_for :users, :controllers => { :registration => 'users', :omniauth_callbacks => "omniauth_callbacks" }

  resources :users, only: [:show]

  namespace :api do
    resources :entries
  end
end
