class AddDeviceFields < ActiveRecord::Migration
  def self.up
  	add_column :devices,:specification_number,:text
	add_column :devices,:arrival_date,:date
	add_column :devices,:responsible,:text
  end

  def self.down
  	delete_column :devices,:specification_number
  	delete_column :devices,:arrival_date
  	delete_column :devices,:responsible
  end
end
