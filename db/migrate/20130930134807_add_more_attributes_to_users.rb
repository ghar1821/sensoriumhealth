class AddMoreAttributesToUsers < ActiveRecord::Migration
  def change
      add_column :users, :city, :string, :limit => "50"
      add_column :users, :gender, :string, :limit => "6"
      add_column :users, :year_of_birth, :integer

  end
end
