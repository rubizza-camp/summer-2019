class CreateUsersRestrauntsReviewsTable < ActiveRecord::Migration[5.2]
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  # :reek:all
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :email, null: false
      t.timestamps
    end

    create_table :restraunts do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :location, null: false
      t.integer :avg_mark, default: 0
      t.timestamps
    end

    create_table :reviews do |t|
      t.string :body, null: false
      t.integer :mark, null: false
      t.integer :user_id, null: false
      t.integer :restraunt_id, null: false
      t.timestamps
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end
