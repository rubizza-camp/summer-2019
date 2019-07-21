module StartCommand
  def start!(*)
    if registered?
      respond_with :message, text: 'No need to register again'
      return
    end
    respond_with :message, text: 'Hello!'
    save_context :number_check
    respond_with :message, text: 'Tell me your Number'
  end

  def number_check(number = nil, *)
    data_redis = Redis.new
    registration_check(data_redis, number)
  end

  private

  def registration(redis, number)
    session[:number] = number
    session[:checkout?] = true
    redis.set(number, from['id'])
  end

  def registration_check(redis, number)
    if redis.get(number) && session.key?(:number)
      respond_with :message, text: "Greetings #{number}!"
    elsif FileAccessor.personal_numbers.include? number
      registration(redis, number)
      respond_with :message, text: 'Registration done!'
    else
      respond_with :message, text: 'Nope, there is no such number in my list'
      respond_with :message, text: "Shame, i can't let you in"
    end
  end
end
