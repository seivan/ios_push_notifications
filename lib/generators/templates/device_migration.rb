class CreateIospnDevices < ActiveRecord::Migration
  def self.up
    create_table :iospn_devices do |t|
      t.text :token, :length => 100, :null => false
      t.datetime :last_registered_at
      t.timestamps
    end
     add_index :iospn_devices, :token, :unique => true
  end

  def self.down
    drop_table :iospn_devices
  end
end



   