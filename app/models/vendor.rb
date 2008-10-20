class Vendor < ActiveRecord::Base
  has_many  :devices, :through => :series
  validates_uniqueness_of :name
  has_many :tools
end
