require "active_record" unless defined?(ActiveRecord)
require "action_view" unless defined?(ActionView)

require "rails" unless defined?(Rails)
  

require 'socket'
require 'openssl'
require "ios_push_notifications/notification"
require "ios_push_notifications/device"
require "ios_push_notifications/configuration"
module IOSPN
  def open_for_delivery(options = {}, &block)
        open(options, &block)
  end
  def open(options = {}, &block)
        options = IOSPN.configuration.notification.merge(options)
        cert = File.read(options[:cert])
        ctx = OpenSSL::SSL::SSLContext.new
        ctx.key = OpenSSL::PKey::RSA.new(cert, options[:passphrase])
        ctx.cert = OpenSSL::X509::Certificate.new(cert)
  
        sock = TCPSocket.new(options[:host], options[:port])
        ssl = OpenSSL::SSL::SSLSocket.new(sock, ctx)
        ssl.sync = true
        ssl.connect
  
        yield ssl, sock if block_given?
        ssl.close
        sock.close
      end

      # Yields up an SSL socket to receive feedback from.
      # The connections are close automatically.
      # Configuration parameters are:
      #       
      def open_for_feedback(options = {}, &block)
        options =  IOSPN.configuration.feedback.merge(options)
        Notification.open(options, &block)
      end
      

end