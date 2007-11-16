class AddChasisOpt < ActiveRecord::Migration
  def self.up
  #Columns
  #device.is_chasis?
  add_column :devices, :is_chasis, :boolean
  end

  def self.down
  remove_column :devices, :is_chasis, :boolean
  end
end
