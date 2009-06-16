class AddDeviceTypes < ActiveRecord::Migration
  def self.up
  	add_column :devices, :devtype, :string	
  end

  def self.down
  	remove_column :devices, :devtype	
  end
end
