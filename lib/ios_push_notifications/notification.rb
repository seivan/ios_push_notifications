module IOSPN
  class Notification < ActiveRecord::Base
    set_table_name "iospn_notifications"
    class << self
      include IOSPN
    end
    belongs_to :device
    include ::ActionView::Helpers::TextHelper

    def alert=(message)
      if !message.blank? && message.size > 150
        message = truncate(message, :length => 150)
      end
      write_attribute(:alert, message)
    end

    def build_hash_for_push_notification
      result = {}
      result['aps'] = {}
      result['aps']['alert'] = self.alert if self.alert
      result['aps']['badge'] = self.badge.to_i if self.badge
      if self.sound
        result['aps']['sound'] = self.sound if self.sound.is_a?(String) && self.sound
      end
      if self.custom_properties
        self.custom_properties.each do |key,value|
          result["#{key}"] = "#{value}"
        end
      end
      result
    end

    def build_hash_for_json
      self.build_hash_for_push_notification.to_json
    end
    
    def build_message_for_sending
          json = self.build_hash_for_json
    message = "\0\0 #{self.device.to_hex}\0#{json.length.chr}#{json}"
    if message.size.to_i > 256
      return false
    else
      message
    end
    end

   def self.send_notifications(notifications =Notification.where(:sent_at => nil))
      unless notifications.nil? || notifications.empty?
       open_for_delivery do |conn, sock|
          notifications.each do |noty|
            conn.write(noty.build_message_for_sending)
            noty.sent_at = Time.now
            noty.save
          end
        end
      end
    end
    
  end
end