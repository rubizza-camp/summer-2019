module Start
  def start!(*)
    if UserStates.already_registered?(from['id'])
      respond_with :message, text: 'You are already registered'
    else
      respond_with :message, text: 'Enter the number'
      save_context :user_number
    end
  end

  def user_number(person_number = nil, *)
    if UserStates.find_user(person_number).empty? && NumberMethods.valid_number?(person_number)
      UserStates.create_user(from['id'], from['firts_name'], person_number)
      respond_with :message, text: 'Registration is successful'
    else
      respond_with :message, text: 'Wrong number'
      save_context :start!
    end
  end
end
