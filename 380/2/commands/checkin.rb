class CheckIn
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    if user
      user.check_in
    else
      u = User.new(tg_id)
      u.check_in
      'Send selfie, please!'
    end
  end
end
