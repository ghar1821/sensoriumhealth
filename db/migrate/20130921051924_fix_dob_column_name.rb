class FixDobColumnName < ActiveRecord::Migration
  def change
      rename_column :users, :dob, :year_of_birth
  end
end
