require_relative 'kids_checker'

module Start
  def start!(*)
    if KidsChecker.registered(from['id'])
      respond_with :message, text: 'I already know you dear.'
    else
      respond_with :message, text: "Hello! You're probably one of my babies, remind me your number."
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if KidsChecker.new(number).correct_data?
      Gest.create(id: from['id'], number: number, in_camp: 'false')
      respond_with :message, text: 'Love you sweetheart:3'
    else
      respond_with :message, text: 'I do not know you, you are not mine!'
      save_context :start!
    end
  end
end
