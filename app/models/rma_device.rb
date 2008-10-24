class RmaDevice < ActiveRecord::Base
	
	has_many:case_naumber
	validates_presence_of :partnumber
end
