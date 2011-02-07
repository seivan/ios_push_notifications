require 'test_helper'
class Notification < Test::Unit::TestCase
  
  def setup
    @notif = IOSPN::Notification.new
  end
  
  def test_notification_instance
    assert @notif
  end
  
  def test_notification_alert
    message = "Hey man what's up?"
    @notif.alert = message
    assert_equal(@notif.alert, message)
  end
  
  
  def test_notification_badge
    number = 5
    @notif.badge = number
    assert_equal(@notif.badge, number)
  end
  
  
end