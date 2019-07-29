# behavior on start command
module StartCommand
  def clear!(*)
    session.clear
  end

  def start!(*)
    return say_to_user_chat('already registered, use /checkin(-out)') if number_registered?

    say_to_user_chat('number request')
    save_context(:number_registration)
  end

  def number_registration(number, *)
    unless CampAllowedNumbers.include_number_in_list?(number.to_i)
      save_context :number_registration
      return say_to_user_chat('failure, try again')
    end
    register_user(number)
  end

  private

  def register_user(number)
    session[:number] = number
    session[:id] = from['id']
    session[:status] = :out
    Redis.new.set(number, from['id'])
    say_to_user_chat('success registration')
  end
end
