# :reek:all
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
    end
  end
end
