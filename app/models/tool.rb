class Tool < ActiveRecord::Base

belongs_to :engineer
belongs_to :vendor

validates_presence_of :partnumber
validates_presence_of :description
validates_presence_of :serialnumber
validates_presence_of :labnumber
validates_presence_of :location
end

