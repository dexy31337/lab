class UpToRmaDevices < ActiveRecord::Migration
   def self.up
  
   add_column :rma_devices,:rma_device_end_date,:date
   add_column :rma_devices,:rma_device_comment,:text

  end

  def self.down
   
   remove_column :rma_devices,:rma_device_end_date
   remove_column :rma_devices,:rma_device_comment

  end
end
