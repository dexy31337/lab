class Device < ActiveRecord::Base
  has_many    :interfaces
  belongs_to  :vendor
  belongs_to  :reservation
  has_one     :ServingProperty
#  validates_uniqueness_of :serialnumber
  validates_uniqueness_of :scope =>'interface_id'
  belongs_to  :device
  has_many    :devices
  belongs_to  :series
  belongs_to  :rma_device
end
