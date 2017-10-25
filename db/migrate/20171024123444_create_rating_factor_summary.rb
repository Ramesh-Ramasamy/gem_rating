class CreateRatingFactorSummary < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_factor_summaries do |t|
      t.integer :rating_factor_id
      t.string :rateable_type
      t.integer :rateable_id
      t.decimal :rating

      t.timestamps
    end

    add_index(:rating_factor_summaries, [:rating_factor_id, :rateable_type, :rateable_id], unique: true, name: "index_on_rating_factor_id_rateable")
  end
end
