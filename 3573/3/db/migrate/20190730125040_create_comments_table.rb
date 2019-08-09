class CreateCommentsTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy
  #:reek:TooManyStatements
  def change
    create_table :comments do |comment|
      comment.string :text
      comment.string :star
      comment.string :place_id
      comment.string :user_id
      comment.string :timestamps
    end
  end
end
