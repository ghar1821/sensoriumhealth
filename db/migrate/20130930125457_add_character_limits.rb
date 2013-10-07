class AddCharacterLimits < ActiveRecord::Migration
  def change
      change_column :users, :firstname, :string, :limit => "30"
      change_column :users, :lastname, :string, :limit => "30"
      change_column :users, :username, :string, :limit => "20"
  end
end
