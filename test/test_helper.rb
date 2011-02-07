require 'rubygems'
require 'test/unit'
require "yaml"
require "logger"

require File.dirname(__FILE__) + '/../init'
ENV['RAILS_ENV'] = 'test'
 

def clean_database!
  models = [IOSPN::Notification, IOSPN::Device]
  begin
    models.each do |model|
      ActiveRecord::Base.connection.execute "DROP TABLE #{model.table_name}"
    end
  rescue ActiveRecord::StatementInvalid
  end
end

 
def load_schema!
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
 
  db_adapter = ENV['DB']
 
  # no db passed, try one of these fine config-free DBs before bombing.
  db_adapter ||=
    begin
      require 'rubygems'
      require 'sqlite'
      'sqlite'
    rescue MissingSourceFile
      begin
        require 'sqlite3'
        'sqlite3'
      rescue MissingSourceFile
      end
    end
 
  if db_adapter.nil?
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."
  end
 
  ActiveRecord::Base.establish_connection(config[db_adapter])

  IOSPN.configure do |c|
    c.notification[:cert] = File.join(Dir.pwd,"test", "apple_push_notification_development.pem")
end



  clean_database!
  load(File.dirname(__FILE__) + "/schema.rb")
end
load_schema!