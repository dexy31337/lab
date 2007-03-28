class DevicesModular < ActiveRecord::Migration
  def self.up
    #Coulumns
    #devices.modular
    add_column  :devices, :modular,  :boolean

  end

  def self.down
    remove_column :devices, :modular
  end
endend
