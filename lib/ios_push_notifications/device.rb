module IOSPN
  class Device < ActiveRecord::Base
  set_table_name "iospn_devices"
  has_many :notifications
  validates_uniqueness_of :token
  validates_format_of :token, :with => /^[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}\s[a-z0-9]{8}$/
  # before_save :set_last_registered_at  
  # private
  # def self.set_last_registered_at
  #   self.last_registered_at = Time.now if self.last_registered_at.nil?
  # end
  
  def save
    self.last_registered_at = Time.now if self.last_registered_at.nil?
    super()
  end
  
  def token=(token)
    res = token.scan(/\<(.+)\>/).first
    unless res.nil? || res.empty?
      token = res.first
    end
    write_attribute('token', token)
  end


  def to_hex
      [self.token.delete(' ')].pack('H*')
    end
  end
  
  
end