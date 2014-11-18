Rails.application.routes.draw do
  root 'static_pages#home'
  namespace :api do
    scope module: :v1, constraints: ApiConstraint.new(version: 1) do
      
      resources :tokens, only: %w(create) do
        collection do
          delete '/' => 'tokens#destroy'
        end
      end
      
      resources :users, :companies, :events
      resources :timelines do
        resources :categories, controller: :timeline_categories
      end
      
      resources :timeline_categories do
        resources :events, controller: :timeline_events
      end
    end
    
    scope module: :v1 do
      resources :tokens, only: %w(create) do
        collection do
          delete '/' => 'tokens#destroy'
        end
      end
      
      resources :users, :companies, :events
      resources :timelines do
        resources :categories, controller: :timeline_categories
      end
      
      resources :timeline_categories do
        resources :events, controller: :timeline_events
      end
    end
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
