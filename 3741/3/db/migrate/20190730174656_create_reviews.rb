# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :stars, null: false
      t.text :comment
      t.integer :user_id, null: false
      t.integer :place_id, null: false
      t.timestamps
    end

    add_index :reviews, :place_id
  end
end
