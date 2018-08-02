class AddAddress < ActiveRecord::Migration
  def change
    add_column :offers, :address, :text
  end
end
