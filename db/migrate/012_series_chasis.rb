class DeviceComments < ActiveRecord::Migration
  def self.up
    #Coulumns
    #devices.comment
    add_column  :series, :chasis,  :bool

  end

  def self.down
    remove_column :series, :chasis
  end
end
