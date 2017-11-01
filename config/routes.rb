Rails.application.routes.draw do
  get 'vendor_rating/home'
  get 'vendor_rating/index'
  get 'vendor_rating/get_rating_factors'
  get 'vendor_rating/get_vendors_rating'
  get 'vendor_rating/get_vendor_rating'
  post 'vendor_rating/bulk_update_rating_factors'
  post 'vendor_rating/update_rating_factor'
  post 'vendor_rating/update_rating_factors'

  namespace :api do
    namespace :v1 do
      resources :rating_events, only: [] do
        collection do
          get :get_data
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
