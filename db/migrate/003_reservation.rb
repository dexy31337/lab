class Reservation < ActiveRecord::Migration
  def self.up
    #Tables
    #Engineers
    create_table    :engineers,   :force => 'true'  do |t|
      t.column  :first, :string, :null => 'false'
      t.column  :last, :string, :null => 'false'
      t.column  :middle, :string, :null => 'false'
    end
    #Reservations
    create_table    :reservations,  :force=>'true'  do |t|
      t.column  :start, :date,  :null => 'false'
      t.column  :end,   :date,  :null => 'false'
      t.column  :comment, :text
      t.column  :engineer_id, :integer, :null => 'false'
    end
    
    #Coulumns
    #devices.reservation
    add_column  :devices, :reservation_id,  :integer
    
    #Relations execute 'ALTER TABLE table ADD CONSTRAINT fk_ FOREIGN KEY (child_id) REFERENCES parents(id)'
    #Devices
    execute 'ALTER TABLE devices ADD CONSTRAINT fk_device_reservation FOREIGN KEY (reservation_id) REFERENCES reservations(id)'
    
    #Reservations
    execute 'ALTER TABLE reservations ADD CONSTRAINT fk_reservation_engineer FOREIGN KEY (engineer_id) REFERENCES engineers(id)'
  end

  def self.down
    execute 'ALTER TABLE devices DROP FOREIGN KEY fk_device_reservation'
    remove_column :devices, :reservation_id
    drop_table    :reservations
    drop_table    :engineers
  end
end
