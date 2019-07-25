require_relative 'kids_checker'

module Start
  def start!(*)
    if KidsChecker.registered(from['id'])
      respond_with :message, text: 'Sorry, but u have already registered!'
    else
      respond_with :message, text: 'Enter your number'
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if KidsChecker.new(number).correct_data?
      Gest.create(id: from['id'], number: number, in_camp: 'false')
      respond_with :message, text: 'Done!'
    else
      respond_with :message, text: 'Wrong number or user is registrated'
      save_context :start!
    end
  end
end