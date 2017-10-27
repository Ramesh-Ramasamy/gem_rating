class RatingFramework < ApplicationRecord

  has_many :rating_factors

  def root_rating_factor
    self.rating_factors.find_by_parent_id(nil)
  end

  def recompute_rating
    (self.name.camelcase + "Engine").recompute_rating(options)
  end
end