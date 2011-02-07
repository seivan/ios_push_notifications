require 'rails/generators/base'
require 'rails/generators/migration'

class IosPushNotificationsGenerator < Rails::Generators::Base #:nodoc:
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
      

      def create_initializer
        template 'initializer.rb', "config/initializers/ios_push_notification.rb"
      end
      
      def create_migration
        migration_template 'device_migration.rb', "db/migrate/create_iospn_devices.rb" 
        migration_template 'notification_migration.rb', "db/migrate/create_iospn_notifications.rb" 
      end

                
      # FIXME: Should be proxied to ActiveRecord::Generators::Base
      # Implement the required interface for Rails::Generators::Migration.
      
      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M#{rand 60}")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

end