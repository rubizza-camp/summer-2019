class User
  include DataMapper::Resource

  property :id, Serial, key: true
  property :useremail, String, length: 3..50
  property :password, BCryptHash

  def authenticate(attempted_password)
    password == attempted_password
  end
end
