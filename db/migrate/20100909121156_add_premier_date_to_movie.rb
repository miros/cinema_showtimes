class AddPremierDateToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :premier_date, :date
  end

  def self.down
    remove_column :movies, :premier_date
  end
end
