class AddFiltersToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :patios, :boolean
    add_column :restaurants, :rooftops, :boolean
    add_column :restaurants, :live_music, :boolean
    add_column :restaurants, :activities, :boolean
    add_column :restaurants, :classic_establishment, :boolean
    add_column :restaurants, :trivia, :boolean
    add_column :restaurants, :movie_location, :boolean
    add_column :restaurants, :dog_friendly, :boolean
    add_column :restaurants, :live_entertainment, :boolean
    add_column :restaurants, :speakeasy, :boolean
    add_column :restaurants, :bottomless_popcorn, :boolean
    add_column :restaurants, :local, :boolean
  end
end
