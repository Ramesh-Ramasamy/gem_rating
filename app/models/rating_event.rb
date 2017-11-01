class RatingEvent < ApplicationRecord
  has_and_belongs_to_many :rating_factors

  def get_data
    self.rating_factors.map(&:get_data).flatten.uniq
  end

  def update_data(data)
    self.rating_factors.map do |rating_factor|
      rating_factor.create_rating!(data)
    end
  end
end