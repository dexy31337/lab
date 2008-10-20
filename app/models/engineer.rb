class Engineer < ActiveRecord::Base
  has_many  :reservations
has_many :tools
end
