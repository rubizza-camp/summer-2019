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
>>>>>>> 94a9c14... working prototype without ill features
    end
  end
end
