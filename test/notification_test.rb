require 'test_helper'
class Notification < Test::Unit::TestCase
  
  def setup
    @notif = IOSPN::Notification.new
    @notif.alert = "Lorem Ipsum"
    @notif.badge = 7
    @notif.sound = "awesome.wav"
    @device = IOSPN::Device.find_or_create_by_token("5gxadhy6 6zmtxfl6 5zpbcxmw ez3w7ksf qscpr55t trknkzap 7yyt45sc g6jrw7qz")
    @notif.device = @device
  end
  
  def test_notification_instance
    assert @notif
  end
  
  
  def test_notification_alert
    message = "Hey man what's up?"
    @notif.alert = message
    assert_equal(@notif.alert, message)
  end
  
  def test_existence_of_sound
    assert_equal @notif.sound, "awesome.wav"
    
  end
  
  def test_notification_truncate_above_150_characters
    long_message = ""
    160.times { |n| long_message << n}
    @notif.alert = long_message
    assert_equal(150, @notif.alert.length)
  end
  
  
  def test_notification_badge
    number = 5
    @notif.badge = number
    assert_equal(@notif.badge, number)
  end
  
  def test_save_notification_without_device
    @notif.device = nil
    assert_raise(ActiveRecord::StatementInvalid) {@notif.save}
    assert_not_nil @notif.errors
  end
  
  def test_save_notification_with_device
    assert(!@notif.device.new_record?)
    assert @notif.save
  end
  
  def test_hash_for_push_notification
    hash = @notif.build_hash_for_push_notification
    assert_instance_of(Hash, hash)
    matcher = {'aps' => {'alert' => @notif.alert, 
                         'badge' => @notif.badge, 
                         'sound' => @notif.sound }}
    assert_equal(matcher, hash)
  end
  
  def test_build_hash_for_json
    assert @notif.build_hash_for_json
  end
  
  def test_build_message_for_sending
    assert(@notif.device.to_hex, "device.to_hex returns false")
    assert(@notif.build_hash_for_json, "notification.build_hash_to_json returns false")
    json = @notif.build_hash_for_json
    message = "\0\0 #{@notif.device.to_hex}\0#{json.length.chr}#{json}"
    assert_equal(@notif.build_message_for_sending, message)
  end
  
  def test_sending_notifications_for_sent_at_nil
    @notif.save
    IOSPN::Notification.send_notifications
    assert(@notif.sent_at, "Notification timestamp was not, has not been sent")
  end
  
  
end