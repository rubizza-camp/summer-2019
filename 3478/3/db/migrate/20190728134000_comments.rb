class Comments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :grade, null: false
      t.text :text, null: false
      t.timestamps
      t.integer  'user_id'
      t.integer  'restaurant_id'
    end
  end
end
