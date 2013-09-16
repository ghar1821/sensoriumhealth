class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :username
      t.date :dob
      t.boolean :gender
      t.string :city

      t.timestamps
    end
  end
end
