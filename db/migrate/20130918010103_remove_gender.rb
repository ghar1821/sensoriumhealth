class RemoveGender < ActiveRecord::Migration
  def self.up
    remove_column :users,  :gender
  end

  def self.down
    add_column  :users,  :gender,    "char(1)"
  end

end
