class CreateRating < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rating_factor_summary_id
      t.decimal :rating
      t.integer :eventable_id
      t.string :eventable_type
      t.string :base_value
      t.string :actual_value
      t.text :additional_details

      t.timestamps
    end

    add_index(:ratings, [:eventable_type, :eventable_id, :rating_factor_summary_id], unique: true, name: "index_on_rating_factor_id_eventable")
  end
end
