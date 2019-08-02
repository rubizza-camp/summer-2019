class CreateShopsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |ttt|
      ttt.text :name
      ttt.text :description
      ttt.text :adress
      ttt.timestamps
    end
  end
end