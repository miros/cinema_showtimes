class CreateCinemas < ActiveRecord::Migration
  def self.up
    create_table :cinemas do |t|
      t.string :name
      t.string :city

    end
  end

  def self.down
    drop_table :cinemas
  end
end
