class RatingFactorSummary < ApplicationRecord
  has_many :ratings
  belongs_to :rating_factor
end