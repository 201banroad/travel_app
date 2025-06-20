class CreateSpots < ActiveRecord::Migration[8.0]
  def change
    create_table :spots do |t|
      t.string :title
      t.string :name
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
