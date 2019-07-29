class Start
  attr_reader :user

  def initialize(tg_id)
    @user = User.find(tg_id)
  end

  def call
    if user.camp_id
      'You are registred! Enter /check_in for check in! :)'
    else
      user.save_status(:waiting_for_number)
      'Cant find your camp id! Are you registred? enter your camp id!'
    end
  end
end
