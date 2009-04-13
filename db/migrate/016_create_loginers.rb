class CreateLoginers < ActiveRecord::Migration
  def self.up
    create_table :loginers do |t|
    end
  end

  def self.down
    drop_table :loginers
  end
end
