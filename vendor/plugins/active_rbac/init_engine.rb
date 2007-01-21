# Project:   ActiveRbac 
# File:      init_engine.rb
# Author:    Manuel Holtgrewe <purestorm at ggnore dot net>
# Copyright: (c) 2005 by Manuel Holtgrewe
# License:   MIT License as follows:
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the 
# following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

# Add lib to the load path
require 'pathname'
$LOAD_PATH.push("#{Pathname.new(__FILE__).dirname.to_s}/lib")
#puts $LOAD_PATH.inspect # THIS IS BUGGY FFS

# require configuration
require "#{Pathname.new(__FILE__).dirname.to_s}/lib/active_rbac_config"

# Configure the Engine's version
module ::ActiveRbacConfig::Version
  Major = 0; Minor = 4; Release = 0
end

Engines.current.version = ActiveRbacConfig::Version

# we need some fixes to rails
require 'railfix'

# require the controller mixins
require 'active_rbac/application_controller_mixin'

# require the model mixins
require 'active_rbac/exceptions'
require 'active_rbac/group_mixin'
require 'active_rbac/role_mixin'
require 'active_rbac/registration_mailer_mixin'
require 'active_rbac/static_permission_mixin'
require 'active_rbac/user_mixin'
require 'active_rbac/user_registration_mixin'

