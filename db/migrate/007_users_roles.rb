class UsersRoles < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column "login", :string, :limit => 40
      t.column "password", :string, :limit => 40 
    end
    User.create(:login => 'admin',:password => 'password',:password_confirmation => 'password')
  end

  def self.down
    drop_table :users
  end
end
