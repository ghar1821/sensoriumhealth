class AddYearOfBirth < ActiveRecord::Migration
  def change
      add_column :users, :year_of_birth, :integer
  end
end
