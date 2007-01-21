class DeviceComments < ActiveRecord::Migration
  def self.up
    #Coulumns
    #devices.comment
    add_column  :devices, :comment,  :text

  end

  def self.down
    remove_column :devices, :comment
  end
end
