class AddAgreedToTermsForOrders < ActiveRecord::Migration[5.2]
  def up
    add_column :spree_orders, :agreed_to_terms, :boolean
  end
  def down
    remove_column :spree_orders, :agreed_to_terms
  end
end
