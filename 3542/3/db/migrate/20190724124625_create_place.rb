# :reek:all
class CreatePlace < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.text :description, default: '', null: false
    end
  end
end
