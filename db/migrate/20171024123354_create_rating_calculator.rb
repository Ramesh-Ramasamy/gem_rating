class CreateRatingCalculator < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_calculators do |t|
      t.string :name
      t.string :type
      t.text :config
      t.integer :rating_factor_id

      t.timestamps
    end
  end
end
