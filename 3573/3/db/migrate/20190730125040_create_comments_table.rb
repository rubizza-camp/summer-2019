class CreateCommentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |c|
      c.string :text
      c.string :star
      c.string :place_id
      c.string :user_id
      c.string :timestamps
    end
  end
end