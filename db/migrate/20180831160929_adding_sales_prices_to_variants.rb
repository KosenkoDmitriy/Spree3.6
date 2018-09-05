class AddingSalesPricesToVariants < ActiveRecord::Migration[5.2]
  def up
    add_column :spree_variants, :main_price, :float, precision: 18, scale: 6
    add_column :spree_variants, :sale_price, :float, precision: 18, scale: 6
  end

  def down
    remove_column :spree_variants, :sale_price
    remove_column :spree_variants, :main_price
  end
end
