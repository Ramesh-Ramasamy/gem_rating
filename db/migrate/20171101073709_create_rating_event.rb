class CreateRatingEvent < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_events do |t|
      t.string :code
      t.string :name
      t.integer :rating_framework_id
    end

    add_index(:rating_events, [:code, :rating_framework_id], unique: true)
  end
end
