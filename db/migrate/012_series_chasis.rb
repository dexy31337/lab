class SeriesChasis < ActiveRecord::Migration
  def self.up
    #Coulumns
    #devices.comment
    add_column  :series, :chasis,  :boolean, :null => false

  end

  def self.down
    remove_column :series, :chasis
  end
end
