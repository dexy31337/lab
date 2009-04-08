class DeviceFieldsCertVynos < ActiveRecord::Migration
  def self.up
  	add_column :devices, :certification, :boolean	
  	add_column :devices, :permited_to_carry_away, :boolean	
  end

  def self.down
  	remove_column :devices, :certification	
  	remove_column :devices, :permited_to_carry_away	
  end
end
