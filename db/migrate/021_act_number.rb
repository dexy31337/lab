class ActNumber < ActiveRecord::Migration
  def self.up
  	add_column :devices, :act_number, :text
  end

  def self.down
  	remove_column :devices, :act_number
  end
end
