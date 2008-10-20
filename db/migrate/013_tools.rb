class Tools < ActiveRecord::Migration
  def self.up
#tools
    create_table    :tools,   :force => true  do |t|
      t.column  :partnumber, :string, :null => false
      t.column  :description, :string, :null => false
      t.column  :serialnumber, :string, :null => false
      t.column  :labnumber, :string, :null => false
      t.column  :location, :string, :null => false
      t.column  :engineer_id,         :integer
      t.column  :vendor_id,           :integer

    end

    execute 'ALTER TABLE tools ADD CONSTRAINT fk_tool_engineer FOREIGN KEY (engineer_id) REFERENCES engineers(id)'
    execute 'ALTER TABLE tools ADD CONSTRAINT fk_tool_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(id)'

  end

  def self.down
    drop_table  :tools
  end
end
