class VendorRatingController < ApplicationController
   skip_before_action :verify_authenticity_token

  def get_rating_factors
    @rating_factors_tree = RatingFactor.where(parent_id: params[:parent_id]).map(&:tree)
  end

  # def bulk_update_rating_factors
  #   # result = begin
  #     ActiveRecord::Base.transaction do
  #       update_rating_factor(params[:rating_factor])
  #       params[:rating_factor][:children].each do |c|
  #         update_rating_factor(c)
  #       end
  #       # current_factor = params[:rating_factor][:children]
  #       # while(current_factor)
  #       #   update_rating_factor(current_factor)
  #       #   current_factor = current_factor[:children]
  #       # end
  #     end
  #     result = {status: "success"}
  #   # rescue => e
  #     # {status: "failed", exception: e.message}
  #   # end
  #   render json: result
  # end


  def update_rating_factor
    rf = RatingFactor.where(id: params[:id]).first
    rf.update_attributes!(permit_params)
    render json: {status: "success"}
  end

  def get_vendors_rating
    rating_data = VendorRatingEngine.get_vendors_rating
  end

  def get_vendor_rating
    rating_data = VendorRatingEngine.get_vendors_rating(params[:vendor_id])
  end

  private
  def permit_params
    params.permit(:weightage, {config: {}})
  end
end
