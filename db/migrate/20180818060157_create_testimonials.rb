class CreateTestimonials < ActiveRecord::Migration[5.2]
  def up
    create_table :testimonials, :force => true do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :name
      t.text     :body
      t.boolean  :enabled
    end
  end
  def down
    drop_table :testimonials
  end
end
