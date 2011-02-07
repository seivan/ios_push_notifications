ActiveRecord::Schema.define(:version => 0) do
    create_table :devices do |t|
      t.text :token, :length => 100, :null => false
      t.datetime :last_registered_at
      t.timestamps
    end
    create_table :notifications do |t|
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
end