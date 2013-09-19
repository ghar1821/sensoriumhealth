class ChangeGender < ActiveRecord::Migration
  def change
      change_column :users, :gender, 'varchar(6)'
  end
end
