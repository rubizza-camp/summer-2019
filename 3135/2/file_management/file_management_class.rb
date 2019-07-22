class SaveSession
  def self.call(user)
    new(user).call
  end

  def initialize(user)
    @photo_uri = @user.photo_uri
    @location = @user.location
  end

  def call

  end

  def path
    "public/#{user.camp_num}/#{user.action.what?}s/#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}"
  end
end