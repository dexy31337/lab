class InitialRbacSchema < ActiveRecord::Migration
  def self.up
	create_table "engine_schema_info", :id => false, :force => true do |t|
		t.column "engine_name", :string
		t.column "version",     :integer
	end
	create_table "groups", :force => true do |t|
		t.column "created_at", :timestamp,                                :null => false
		t.column "updated_at", :timestamp,                                :null => false
		t.column "title",      :string,    :limit => 200, :default => "", :null => false
		t.column "parent_id",  :integer,   :limit => 10
	end
	
	add_index "groups", ["parent_id"], :name => "groups_parent_id_index"
	
	create_table "groups_roles", :id => false, :force => true do |t|
		t.column "group_id",   :integer,   :limit => 10, :default => 0, :null => false
		t.column "role_id",    :integer,   :limit => 10, :default => 0, :null => false
		t.column "created_at", :timestamp,                              :null => false
	end
	
	add_index "groups_roles", ["group_id", "role_id"], :name => "groups_roles_all_index", :unique => true
	add_index "groups_roles", ["role_id"], :name => "role_id"
	
	create_table "groups_users", :id => false, :force => true do |t|
		t.column "group_id",   :integer,   :limit => 10, :default => 0, :null => false
		t.column "user_id",    :integer,   :limit => 10, :default => 0, :null => false
		t.column "created_at", :timestamp,                              :null => false
	end
	
	add_index "groups_users", ["group_id", "user_id"], :name => "groups_users_all_index", :unique => true
	add_index "groups_users", ["user_id"], :name => "user_id"
	
	create_table "roles", :force => true do |t|
		t.column "created_at", :timestamp,                                :null => false
		t.column "updated_at", :timestamp,                                :null => false
		t.column "title",      :string,    :limit => 100, :default => "", :null => false
		t.column "parent_id",  :integer,   :limit => 10
	end
	
	add_index "roles", ["parent_id"], :name => "roles_parent_id_index"
	
	create_table "roles_static_permissions", :id => false, :force => true do |t|
		t.column "role_id",              :integer,   :limit => 10, :default => 0, :null => false
		t.column "static_permission_id", :integer,   :limit => 10, :default => 0, :null => false
		t.column "created_at",           :timestamp,                              :null => false
	end
	
	add_index "roles_static_permissions", ["static_permission_id", "role_id"], :name => "roles_static_permissions_all_index", :unique => true
	add_index "roles_static_permissions", ["role_id"], :name => "role_id"
	
	create_table "roles_users", :id => false, :force => true do |t|
		t.column "user_id",    :integer,   :limit => 10, :default => 0, :null => false
		t.column "role_id",    :integer,   :limit => 10, :default => 0, :null => false
		t.column "created_at", :timestamp,                              :null => false
	end
	
	add_index "roles_users", ["user_id", "role_id"], :name => "roles_users_all_index", :unique => true
	add_index "roles_users", ["role_id"], :name => "role_id"
	create_table "static_permissions", :force => true do |t|
		t.column "title",      :string,    :limit => 200, :default => "", :null => false
		t.column "created_at", :timestamp,                                :null => false
		t.column "updated_at", :timestamp,                                :null => false
	end
	
	add_index "static_permissions", ["title"], :name => "static_permissions_title_index", :unique => true
	
	create_table "user_registrations", :force => true do |t|
		t.column "user_id",    :integer,   :limit => 10, :default => 0,  :null => false
		t.column "token",      :text,                    :default => "", :null => false
		t.column "created_at", :timestamp,                               :null => false
		t.column "expires_at", :timestamp,                               :null => false
	end
	
	add_index "user_registrations", ["user_id"], :name => "user_registrations_user_id_index", :unique => true
	add_index "user_registrations", ["expires_at"], :name => "user_registrations_expires_at_index"
	
	create_table "users", :force => true do |t|
	t.column "created_at",          :timestamp,                                          :null => false
	t.column "updated_at",          :timestamp,                                          :null => false
	t.column "last_logged_in_at",   :timestamp,                                          :null => false
	t.column "login_failure_count", :integer,   :limit => 10,  :default => 0,            :null => false
	t.column "login",               :string,    :limit => 100, :default => "",           :null => false
	t.column "email",               :string,    :limit => 200, :default => "",           :null => false
	t.column "password",            :string,    :limit => 100, :default => "",           :null => false
	t.column "password_hash_type",  :string,    :limit => 20,  :default => "",           :null => false
	t.column "password_salt",       :string,    :limit => 10,  :default => "1234512345", :null => false
	t.column "state",               :integer,   :limit => 10,  :default => 1,            :null => false
	end
	
	add_index "users", ["login"], :name => "users_login_index", :unique => true
	add_index "users", ["password"], :name => "users_password_index"
	
	role = Role.new
	role.title = "Admin"
	role.save
	
	user = User.new
	user.login = 'admin'
	user.email = 'root@localhost'
	user.state = User.states['confirmed']
	user.update_password('password')
	user.roles << role
	user.save
	user.update_password('password')
	user.save
	
  end

  def self.down
  	
  	drop_table "user_registrations"
  	drop_table "roles_users"
  	drop_table "roles_static_permissions"
  	drop_table "groups_users"
  	drop_table "groups_roles"
  	drop_table "engine_schema_info"
  	drop_table "static_permissions"
  	drop_table "roles"
  	drop_table "groups"
  	drop_table "users"
  end
end
