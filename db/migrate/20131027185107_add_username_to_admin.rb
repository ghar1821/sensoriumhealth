class AddUsernameToAdmin < ActiveRecord::Migration
  def change
  	add_column :admins, :username, :string, :limit => "20", :unique => true
  end
end
