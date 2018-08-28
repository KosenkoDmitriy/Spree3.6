class AddLatLong < ActiveRecord::Migration
  # add address, postcode, lat & long to offers.
  def change
    add_column :offers, :latitude, :float
    add_column :offers, :longitude, :float
    add_column :offers, :postcode, :string
  end
end
