class RatingFramework < ApplicationRecord
  def recompute_rating
    (self.name.camelcase + "Engine").recompute_rating(options)
  end
end