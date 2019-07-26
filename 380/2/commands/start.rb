<<<<<<< HEAD
<<<<<<< HEAD
module Start
  def start(dialog)
    case dialog.status
    when nil
      dialog.change_status('not_registred')
      dialog.say_to_user('Enter your number:')
    when 'not_registred'
      dialog.say_to_user('Enter your number:')
    when 'registred'
      dialog.say_to_user('You are registred! Enter /check_in for check in! :)')
=======
=======
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
class Start
  attr_reader :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call
    user = User.find(tg_id)
<<<<<<< HEAD
    if user
      'You are registred! Enter /check_in for check in! :)'
    else
      u = User.new(tg_id)
      u.register
      'Enter you number:'
>>>>>>> 94a9c14... working prototype without ill features
=======
    if user.camp_id
      'You are registred! Enter /check_in for check in! :)'
    else
      user.save_status(:waiting_for_number)
      'Cant find your camp id! Are you registred? enter your camp id!'
>>>>>>> 8ef874f22a9a9f5675fca28d5c151f7e1f71fa75
    end
  end
end
