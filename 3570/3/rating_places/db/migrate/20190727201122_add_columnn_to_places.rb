class AddColumnnToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :short_description, :text
  end
end
