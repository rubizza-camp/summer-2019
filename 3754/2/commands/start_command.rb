module StartCommand
  def start!(*)
    respond_with :message, text: "Hi, #{from['first_name']}! Give me your own number"
    save_context :check_number_in_file
  end

  def check_number_in_file(*words)
    personal_numbers = YAML.load_file(File.open('data/users.yml'))['numbers']
    return check_telegram_id_in_db(words[0]) if personal_numbers.include? words[0].to_i
    respond_with :message, text: 'This number doesn\'t exist. Try again'
    save_context :check_number_in_file
  end

  def check_telegram_id_in_db(number)
    return check_number_in_db(number) if Database.redis.exists(from['id'])
    sign_up(number)
  end

  def check_number_in_db(number)
    if Database.redis.get(from['id']).to_i == number.to_i
      respond_with :message, text: 'You are in the system. Use /checkin or /checkout'
    else
      respond_with :message, text: 'This is not your number. Try again'
      save_context :check_number_in_file
    end
  end

  def sign_up(number)
    Database.redis.set(from['id'], number.to_s + 'no')
    respond_with :message, text: 'You are registered. Use /checkin or /checkout'
  end
end
