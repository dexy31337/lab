class ModifyUsers < ActiveRecord::Migration
  def self.up
   #Columns
   #engineers.email
   add_column :engineers, :work_phone,	:string
   add_column :engineers, :cell_phone,	:string
   add_column :engineers, :email, :string

  end

  def self.down
   remove_column :engineers, :work_phone
   remove_column :engineers, :cell_phone
   remove_column :engineers, :email
  end
end
