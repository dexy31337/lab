class AddBundleToDevises < ActiveRecord::Migration
  def self.up
    add_column  :devices, :is_bundle,  :integer

  end

  def self.down
    remove_column :devices, :is_bundle
  end
end
