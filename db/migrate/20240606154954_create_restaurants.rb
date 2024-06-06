class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :neighborhood
      t.string :link
      t.string :deal
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :sunday
      t.string :price
      t.string :restaurant_type
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
