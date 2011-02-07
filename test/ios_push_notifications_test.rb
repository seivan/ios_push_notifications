require 'test_helper'
class IosPushNotificationsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
 load_schema
 
  class Notification < ActiveRecord::Base
  end
 
  class Device < ActiveRecord::Base
  end
 
  def test_schema_has_loaded_correctly
    assert_equal [], Device.all
    assert_equal [], Notification.all
  end
  test "the truth" do
    assert true
  end
end
