class CreateIospnNotifications < ActiveRecord::Migration # :nodoc:
  
  def self.up

    create_table :iospn_notifications do |t|
      t.integer :device_id, :null => false
      t.integer :errors_nb, :default => 0 # used for storing errors from apple feedbacks
      t.string :device_language, :size => 5 # if you don't want to send localized strings
      t.string :sound
      t.string :alert, :size => 150
      t.integer :badge
      t.text :custom_properties
      t.datetime :sent_at
      t.timestamps
    end
    
    add_index :iospn_notifications, :device_id
    add_index :iospn_notifications, :sent_at
  end

  def self.down
    drop_table :iospn_notifications
  end  
end
