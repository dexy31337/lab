require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base
  include ActiveRbacMixins::UserMixins::Core
  include ActiveRbacMixins::UserMixins::Validation
  def self.authenticate(login, pass)
    find_first(["login = ? AND password = ?", login, sha1(pass)])
  end  

  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end
    
  protected

  def self.sha1(pass)
    Digest::SHA1.hexdigest("change-me--#{pass}--")
  end
    
  before_create :crypt_password
  
  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end

  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :login, :password
  validates_uniqueness_of :login, :on => :create
  validates_confirmation_of :password, :on => :create     
end
