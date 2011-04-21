class SpecPoDate < ActiveRecord::Migration
  def self.up
  	add_column  :devices, :partner_spec,  :text
  	add_column  :devices, :po_number,  :text
  	add_column  :devices, :purchase_date,  :text
  end

  def self.down
  	remove_column  :devices, :partner_spec
  	remove_column  :devices, :po_number
  	remove_column  :devices, :purchase_date
  end
end
