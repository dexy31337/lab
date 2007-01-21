class Role < ActiveRecord::Base
  include ActiveRbacMixins::RoleMixins::Core
  include ActiveRbacMixins::RoleMixins::Validation
end
