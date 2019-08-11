class AddFullDescriptionColumnToLocationsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :full_description, :string
  end
end
