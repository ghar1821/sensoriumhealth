# used to enforce uniqueness at database level.
# uniqueness at interface level doesn't help 
# if user accidentally click submit button twice when registering,
# Request 1 will create user in memory that passes validation, 
# Request 2 does the same, request 1's user gets saved, and request 2's user gets saved.
# Thus same user email.
#
# Using email index to enforce uniqueness at database level.
# Can be handled in Rails using migrations.
# Command: rails generate migration add_index_to_users_email.
# This add structure to an existing model.

class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
      add_index :users, :email, unique: true
  end
end
