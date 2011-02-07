module IOSPN
  class Configuration
    attr_accessor :feedback,:notification
    
    def initialize
      @feedback = {}
      @notification = {}
      @notification = {:passphrase => '', :port => 2195}
      @feedback = {:passphrase => @notification[:passphrase], :port => 2196}
      if Rails.env.production?
        @notification[:host] = "gateway.push.apple.com"
        @notification[:cert] = File.join(Rails.root, 'config', 'apple_push_notification_production.pem') if Rails.root
        @feedback[:host] = "feedback.push.apple.com"
        @feedback[:cert] = @notification[:cert]
      else
        @notification[:host] = "gateway.sandbox.push.apple.com"
        @notification[:cert] = File.join(Rails.root, 'config', 'apple_push_notification_development.pem') if Rails.root
        @feedback[:host] = "feedback.sandbox.push.apple.com"
        @feedback[:cert] = @notification[:cert]
      end
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end  
end