<<<<<<< HEAD
<<<<<<< HEAD
module Register
  def register(dialog)
    case dialog.status
    when 'not_registred'
      sign_in(dialog)
    when 'registred'
      already_here(dialog)
    end
  end

  private

  def sign_in(dialog)
    dialog.database.set(dialog.chat_id, dialog.user_said.to_i)
    dialog.change_status('registred')
    dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
  end

  def already_here(dialog)
    dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
=======
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
>>>>>>> 94a9c14... working prototype without ill features
=======
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
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
  end
end
