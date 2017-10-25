class CreateRatingFactor < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_factors do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :parent_id
      t.integer :weightage
      t.integer :rating_calculator_id
      t.integer :rating_framework_id
      t.string :next_time

      t.timestamps
    end

    add_index(:rating_factors, [:code, :rating_framework_id], unique: true)
  end
end
