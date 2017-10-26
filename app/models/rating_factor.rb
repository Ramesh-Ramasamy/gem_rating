class RatingFactor < ApplicationRecord
  belongs_to :rating_calculator
  belongs_to :rating_framework
  serialize :config, Hash
  # after_update :recompute_rating

  def config
    self[:config] ||= {}
  end

  def recompute_rating
    (self.rating_framework.camelcase + "Engine").constantize.recompute_rating
  end

  def immediate_children
    RatingFactor.where(parent_id: self.id)
  end

  def tree
    if immediate_children.empty?
      {
        :id => id,
        :code => code,
        :attrs => {
          :code => code,
          :name => name,
          :weightage => weightage,
          :config => config
        }
      }
    else
      {
        :id => id,
        :code => code,
        :attrs => {
          :code => code,
          :name => name,
          :weightage => weightage,
          :config => config
        },
        :children => immediate_children.map(&:tree)
      }
    end
  end
end
