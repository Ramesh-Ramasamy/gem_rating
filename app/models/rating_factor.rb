class RatingFactor < ApplicationRecord
  # belongs_to :rating_calculator

  def immediate_children
    RatingFactor.where(parent_id: self.id)
  end

  def tree
    if immediate_children.empty?
      {
        :code => code,
        :attrs => {
          :code => code,
          :name => name,
          :weightage => weightage,
          :config => "self.rating_calculator.config"
        }
      }
    else
      {
        :code => code,
        :attrs => {
          :code => code,
          :name => name,
          :weightage => weightage,
          :config => "self.rating_calculator.config"
        },
        :children => immediate_children.map(&:tree)
      }
    end
  end
end
