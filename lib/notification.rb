module IOSPN
  class Notification < ActiveRecord::Base
  
  def alert=(message)
    if !message.blank? && message.size > 150
      message = truncate(message, :length => 150)
    end
    write_attribute(:alert, message)
  end

  end
end