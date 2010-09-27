class Add3dToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :is_3d, :boolean
  end

  def self.down
    remove_column :movies, :is_3d
  end
end
