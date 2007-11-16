class Series < ActiveRecord::Base
belongs_to	:vendor
has_many	:devices
has_and_belongs_to_many :series, :join_table => 'compatibility', :association_foreign_key => 'destination_id', :foreign_key => 'source_id'
end
