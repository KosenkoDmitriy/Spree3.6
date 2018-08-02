class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.boolean :enabled
      t.string :title
      t.string :location
      t.text :description
      t.text :offer
      t.boolean :view_by_appt
      t.string :contact_email
      t.string :contact_tel
    end
  end

end
