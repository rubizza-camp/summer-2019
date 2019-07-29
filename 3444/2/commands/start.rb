module Start
  def start!(*)
    if redis.get(session[:number])
      respond_with :message, text: "Registered, id #{session[:number]}"
    else
      save_context :register
      respond_with :message, text: 'What is ur ID'
    end
  end

  def logout!(*)
    if session[:number]
      redis.del(session[:number])
      respond_with :message, text: 'Done, logout sucessfully'
    else
      repeat('Please register before, enter ur id')
    end
  end

  def register(number)
    if redis.get(number)
      respond_with :message, text: 'Already registered'
    elsif check_id?(number)
      session[:number] = number
      redis.set(number, user_id)
      respond_with :message, text: 'Registered!'
    else
      repeat('Check ur number')
    end
  end

  private

  def repeat(err_message)
    save_context :register
    respond_with :message, text: err_message
  end

  def check_id?(number)
    students = YAML.load_file('data/list.yml').dig('students')

    students.include?(number.to_i)
  end

  def user_id
    payload['from']['id']
  end

  def redis
    Redis.new
  end
end
