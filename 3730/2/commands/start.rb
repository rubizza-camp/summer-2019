module StartCommand
  def start!(*)
    if session[:number]
      respond_with :message, text: "Already registered under #{session[:number]} on this devise"
    else
      save_context :register
      respond_with :message, text: 'Hi, what is your number?'
    end
  end

  def register(number)
    redis = Redis.new
    check_in_db(redis, number)
  end

  private

  def exists?(number)
    members_list = YAML.load_file('data/rubizza_members.yml').dig('members')

    members_list.include?(number.to_i)
  end

  def check_in_db(redis, number)
    if redis.get(number)
      respond_with :message, text: 'You have already registered on other devise'
    elsif exists?(number)
      session[:number] = number
      redis.set(number, user_id)
      respond_with :message, text: 'Success, registration completed'
    else
      respond_with :message, text: 'Wrong number, no such member'
    end
  end

  def user_id
    payload['from']['id']
  end
end
