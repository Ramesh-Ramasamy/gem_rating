Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      match '*path', to: 'base#cors_preflight',  via: [:OPTIONS]
      resources :rating_events, only: [] do
        collection do
          get :get_data
        end
      end

      resources :vendor_rating, only: [] do
        collection do
          get :get_rating_factors
          get :get_vendors_rating
          get :get_vendor_rating
          post :bulk_update_rating_factors
          post :update_rating_factor
          post :update_rating_factors
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
