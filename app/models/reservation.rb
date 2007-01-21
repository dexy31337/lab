class Reservation < ActiveRecord::Base
  has_many    :devices
  belongs_to  :engineer
end
