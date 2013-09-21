class AddTermsConditionsAgreementStatus < ActiveRecord::Migration
  def change
      add_column :users, :terms_conditions_agreement, :boolean
  end
end
