class AddUrlToOffersTable < ActiveRecord::Migration
  def change
    add_column :offers, :website, :string
  end
end
