class Servers < ActiveRecord::Migration
  def self.up
  #Tables
  #ServingProperties
  create_table :serving_properties,	:force => 'true' do |t|
  	t.column :cpu_count,	:integer,	:null => 'false'
	t.column :cpu_type, 	:string,	:null => 'false'
	t.column :ram,		:integer,	:null => 'false'
	t.column :disks_total,	:integer
	t.column :disks_layout,	:string
	t.column :os,		:string
	t.column :admin_login,	:string
	t.column :admin_pass,	:string
  end
  
  #Columns
  #devices.serving_properties_id
	add_column :devices, 	:serving_property_id,	:integer
  #Relations execute 'ALTER TABLE table ADD CONSTRAINT fk_ FOREIGN KEY (child_id) REFERENCES parents(id)'
  execute 'ALTER TABLE devices ADD CONSTRAINT fk_device_serving_property FOREIGN KEY (serving_property_id) REFERENCES serving_properties(id)'
  end

  def self.down
  	execute 'ALTER TABLE devices DROP FOREIGN KEY fk_device_serving_properties'
  	remove_column :devices,	:serving_properties_id
	drop_table :serving_properties
  end
end
