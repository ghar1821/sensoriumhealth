class RemovePrivacyAttribute < ActiveRecord::Migration
  def change
      remove_column :users, :terms_conditions_agreement
  end
end
