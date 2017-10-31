Rails.application.routes.draw do
  get 'vendor_rating/home'
  get 'vendor_rating/index'
  get 'vendor_rating/get_rating_factors'
  post 'vendor_rating/bulk_update_rating_factors'
  post 'vendor_rating/update_rating_factor'
  post 'vendor_rating/update_rating_factors'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
