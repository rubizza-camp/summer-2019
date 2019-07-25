class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :mark, null: false
      t.text :annotation, null: false
      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false
      t.timestamps
    end
  end
end
