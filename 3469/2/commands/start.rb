module Start
  FILE_WITH_NUMBERS = './data/number.yml'.freeze

  def start!(number = nil, *)
    return unless new_user?
    if number
      verification_of_information(number)
    else
      save_context :start!
      respond_with :message, text: 'Введите свой номер rubizza!'
    end
  end

  private

  def new_user?
    if session[:rubizza_num].to_s.empty?
      true
    else
      respond_with :message, text: 'Ты уже зарегистрирован!!!'
      false
    end
  end

  def verification_of_information(number)
    redis = Redis.new
    register_new_user(redis, number) if rubizza_number?(number) && !num_is_used?(redis, number)
  end

  def rubizza_number?(number)
    rubizza_numbers = YAML.load_file(FILE_WITH_NUMBERS)['numbers']
    return true if rubizza_numbers.include?(number)
    respond_with :message, text: 'Нет такого номера!'
    false
  end

  def num_is_used?(redis, number)
    respond_with :message, text: 'Этот номер закреплен за другим человеком!' if redis.get(number)
  end

  def register_new_user(redis, number)
    session[:telegram_id] = from['id']
    session[:rubizza_num] = number
    redis.set(number, session[:telegram_id])
    respond_with :message, text: 'Аккаунт зарегистрирован!'
  end
end
