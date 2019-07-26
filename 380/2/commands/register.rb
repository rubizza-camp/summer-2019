class Register
  attr_reader :tg_id, :camp_id

  USER_LIST = []

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call(camp_id)
    puts "USER LIST =[#{USER_LIST}]"
    if USER_LIST.include?(camp_id)
      'You are registred! Enter /check_in for check in! :)'
    else
      user = User.create(tg_id, camp_id)
      user.save_status(:checked_out)
      USER_LIST.push(camp_id)
      "Welcome to camp, Comrade No #{camp_id}!"
    end
  end
end
