class CreateRestarauntTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaraunts do |t|
      t.string :name
      t.text :description
      t.string :coordinate
    end
  end
end
