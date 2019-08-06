# :reek:FeatureEnvy
# :reek:TooManyStatements
class AddValidation < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_hash, false

    change_column_null :places, :name, false
    change_column_default :places, :rating, 0

    change_column_null :comments, :rating, false
    change_column_null :comments, :text, false
    change_column_null :comments, :user_id, false
    change_column_null :comments, :place_id, false
  end
end
