class Comment
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
  property :rate, Integer
  property :user_id, Integer
  property :created_at, DateTime

  belongs_to :bar
end
