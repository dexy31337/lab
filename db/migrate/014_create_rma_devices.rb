class CreateRmaDevices < ActiveRecord::Migration
  def self.up
    create_table :rma_devices do |t|
	t.column :case_number, :string,:null => false
    end
	add_column  :devices, :rma_device_id,  :integer
    execute 'ALTER TABLE devices ADD CONSTRAINT fk_devices_rma_devices FOREIGN KEY (rma_device_id) REFERENCES engineers(id)'

  end	

  def self.down
    execute 'ALTER TABLE devices DROP FOREIGN KEY fk_device_rma_devaces'
    remove_column :devices, :reservation_id
    drop_table :rma_devices
  end
end

