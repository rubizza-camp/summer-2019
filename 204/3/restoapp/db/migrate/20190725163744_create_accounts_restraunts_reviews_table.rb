class CreateAccountsRestrauntsReviewsTable < ActiveRecord::Migration[5.2]
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  # :reek:all
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :email, null: false, unique: true
      t.timestamps
    end

    create_table :restraunts do |t|
      t.string :title, null: false, unique: true
      t.string :description, null: false
      t.string :google_map_link, null: false
      t.integer :avg_rate, default: 0
      t.timestamps
    end

    create_table :reviews do |t|
      t.string :body, null: false
      t.integer :rate, null: false
      t.integer :account_id, null: false
      t.integer :restraunt_id, null: false
      t.timestamps
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end
