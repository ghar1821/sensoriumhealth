class DropDob < ActiveRecord::Migration
  def change
      remove_column :users, :dob
  end
end
