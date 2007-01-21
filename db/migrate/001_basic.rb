class Basic < ActiveRecord::Migration
  def self.up
    #Tables
    #Vendors
    create_table  :vendors,         :force=>true  do |t|
      t.column  :name,              :string,  :null=>false
    end
    execute 'INSERT INTO vendors (name) VALUES ("Unknown")'
    
    #Interface types
    create_table  :interface_types, :force=>true do |t|
      t.column  :name,              :string,  :null=>false
    end 
    #Interfaces
    create_table  :interfaces,      :force=>true do |t|
      t.column  :name,              :string,  :null=>false
      t.column  :interface_type_id, :integer, :null=>false
      t.column  :device_id,         :integer, :null=>false
      t.column  :interface_id,      :integer
    end
    #Devices
    create_table  :devices,         :force=>true do |t|
      t.column  :name,              :string,  :null=>false
      t.column  :partnumber,        :string,  :null=>false
      t.column  :serialnumber,      :string
      t.column  :labnumber,         :string,  :null=>false
      t.column  :device_id,         :integer
      t.column  :vendor_id,         :integer, :null=>false
    end
    
    #Relations execute 'ALTER TABLE table ADD CONSTRAINT fk_ FOREIGN KEY (child_id) REFERENCES parents(id)'
    #Devices
    execute 'ALTER TABLE devices ADD CONSTRAINT fk_device_device FOREIGN KEY (device_id) REFERENCES devices(id)'
    execute 'ALTER TABLE devices ADD CONSTRAINT fk_device_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(id)'
    
    #Interfaces
    execute 'ALTER TABLE interfaces ADD CONSTRAINT fk_interface_interface_type FOREIGN KEY (interface_type_id) REFERENCES interface_types(id)'
    execute 'ALTER TABLE interfaces ADD CONSTRAINT fk_interface_device FOREIGN KEY (device_id) REFERENCES devices(id)'
    execute 'ALTER TABLE interfaces ADD CONSTRAINT fk_interface_interface FOREIGN KEY (interface_id) REFERENCES interfaces(id)'
    
  end

  def self.down
    drop_table  :interfaces
    drop_table  :interface_types
    drop_table  :devices
    drop_table  :vendors
  end
end
