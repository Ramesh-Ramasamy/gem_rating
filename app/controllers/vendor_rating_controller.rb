class VendorRatingController < ApplicationController
  def get_rating_factors
    result = RatingFactor.where(parent_id: params[:parent_id]).first.tree
    render json: result
  end
end
