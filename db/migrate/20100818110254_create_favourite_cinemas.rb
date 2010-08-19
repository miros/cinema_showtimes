class CreateFavouriteCinemas < ActiveRecord::Migration
  def self.up
    create_table :favourite_cinemas do |t|
      t.integer :user_id
      t.integer :cinema_id
    end
  end

  def self.down
    drop_table :favourite_cinemas
  end
end
