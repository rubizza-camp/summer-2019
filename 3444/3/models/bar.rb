class Bar
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :description, Text
  property :body, Text
  property :coordinates, Text
  property :created_at, DateTime

  has n, :comments
end
