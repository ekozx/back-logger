Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #TODO: Refactor these with better namespaces
  # You can have the root of your site routed with "root"
  root 'backlog#index'
  resources :entries
  resources :associations
  resources :relationships, only: [:create, :destroy]
  devise_for :users, :controllers => { :registration => 'users', :omniauth_callbacks => "omniauth_callbacks" }
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'backlog/unbuilt'      => 'backlog#unbuilt'
  get 'search'               => 'search#index'
  get 'search/:type/:query/:t'  => 'search#query'
  get 'search/reindex'       => 'search#reindex'
  get 'entries/remove/:id'   => 'entries#delete'
  get 'entries/add/:id'      => 'entries#add'
  get '/entries/'            => 'entries#new'
  get 'users/edit'           => 'users#edit'
  get 'users/followers'      => 'users#followers'
  get 'users/following'      => 'users#following'
  get 'users/follow/:id'     => 'users#follow'
  get 'users/unfollow/:id'   => 'users#unfollow'

  resources :users, only: [:show]
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
