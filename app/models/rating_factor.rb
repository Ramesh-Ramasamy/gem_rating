class RatingFactor < ApplicationRecord
  belongs_to :rating_calculator
  belongs_to :rating_framework
  belongs_to :rateable, polymorphic: true
  has_many :rating_factor_summaries
  serialize :config, Hash
  # after_update :recompute_rating

  def config
    self[:config] ||= {}
  end

  def get_data
    config["data_needed"]
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
        :name => name,
        :weightage => weightage,
        :config => config,
        :description => description
      }
    else
      {
        :id => id,
        :code => code,
        :name => name,
        :weightage => weightage,
        :config => config,
        :description => description,
        :children => immediate_children.map(&:tree)
      }
    end
  end
end
