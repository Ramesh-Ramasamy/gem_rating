class CreateRatingEventsFactor < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_events_factors, id: false do |t|
      t.belongs_to :rating_event, index: true
      t.belongs_to :rating_factor, index: true
    end
  end
end
