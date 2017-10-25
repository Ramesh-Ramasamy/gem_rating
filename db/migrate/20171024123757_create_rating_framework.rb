class CreateRatingFramework < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_frameworks do |t|
      t.string :name
      t.string :description
      t.text :options

      t.timestamps
    end
  end
end
