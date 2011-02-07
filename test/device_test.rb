require 'test_helper'
class Device < Test::Unit::TestCase
  
  def setup
    @device = IOSPN::Device.new(:token => "5gxadhy6 6zmtxfl6 5zpbcxmw ez3w7ksf qscpr55t trknkzap 7yyt45sc g6jrw7qz")
  end
  
  def test_notification_instance
    assert @device
  end
  
  def test_notification_token
    token = @device.token
    @device.token = "<#{token}>"
    assert_equal(token, @device.token)
  end
  
  def test_registered_at_before_save
    assert(@device.last_registered_at.nil?)
    @device.save
    assert(@device.last_registered_at)
  end
  
  def test_has_many_notifications
    5.times do 
      @device.notifications << IOSPN::Notification.new
    end
    @device.save
    assert_equal(@device.notifications.count, 5)
  end
  
  def test_unique_token
    @device.save
    bad_device = IOSPN::Device.create(:token => @device.token)
    assert bad_device.errors
  end
end