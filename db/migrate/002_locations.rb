class Locations < ActiveRecord::Migration
  def self.up
    add_column :devices, :location, :string
    add_column :devices, :box_location, :string
  end

  def self.down
    remove_column :devices, :location
    remove_column :devices, :box_location
  end
end
