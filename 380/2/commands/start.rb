class Start
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    if user
      'You are registred! Enter /check_in for check in! :)'
    else
      u = User.new(tg_id)
      u.register
      'Enter you number:'
    end
  end
end
