class Register
  attr_reader :tg_id

  USER_LIST = [10, 11, 12, 13].freeze

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call(number)
    if USER_LIST.include?(number)
      User.create(tg_id, number)
      'You are registred! Enter /check_in for check in! :)'
    else
      'Wrong camp id'
    end
  end
end
