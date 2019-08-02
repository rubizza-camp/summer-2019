# :reek:all
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :description, default: ''
    end
  end
end
