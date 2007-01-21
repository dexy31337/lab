class Interface < ActiveRecord::Base
belongs_to  :device
belongs_to  :interface
has_one     :Interface
belongs_to  :InterfaceType
end
