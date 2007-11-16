class Compatibility < ActiveRecord::Migration
  def self.up
  	#Table
	#Compatibility
	create_table :series,	:force => :true do |t|
		t.column :vendor_id,	:integer, 	:null=>false
		t.column :name,		:string,	:null=>false
	end
	create_table :compatibility, :force => :true , :id => false do |t|
		t.column :source_id,		:integer, 	:null => false
		t.column :destination_id,	:integer,	:null => false
	end
  	#Relations execute 'ALTER TABLE table ADD CONSTRAINT fk_ FOREIGN KEY (child_id) REFERENCES parents(id)'
  	execute 'ALTER TABLE compatibility ADD CONSTRAINT fk_series_source FOREIGN KEY (source_id) REFERENCES series(id)'
  	execute 'ALTER TABLE compatibility ADD CONSTRAINT fk_series_destination FOREIGN KEY (destination_id) REFERENCES series(id)'
	#Columns
	add_column :devices, :series_id, :integer
  	execute 'ALTER TABLE devices ADD CONSTRAINT fk_device_series FOREIGN KEY (series_id) REFERENCES series(id)'
	
  end	
  
  def self.down
  	execute 'ALTER TABLE devices DROP FOREIGN KEY fk_device_series'
	remove_column :devices, :series_id
  	drop_table :compatibility
	drop_table :series
  end
end
