class Start
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
    if user.camp_id
      'You are registred! Enter /check_in for check in! :)'
    else
      user.waiting_for_number
      puts "user.current_state afer user.waiting_for_number: #{user.current_state}"
      'Cant find your camp id! Are you registred? enter your camp id!'
    end
  end
end
