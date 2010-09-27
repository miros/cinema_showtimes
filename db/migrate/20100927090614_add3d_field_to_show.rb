class Add3dFieldToShow < ActiveRecord::Migration
  def self.up
     add_column :shows, :is_3d, :boolean
  end

  def self.down
     remove_column :shows, :is_3d
  end
end
