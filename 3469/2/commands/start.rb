module Start
  FILE_WITH_NUMBERS = './data/number.yml'.freeze

  def start!(number = nil, *)
    return unless new_user?
    if number
      register_user(number)
    else
      save_context :start!
      respond_with :message, text: 'Введите свой номер'
    end
  end

  private

  def new_user?
    if session[:rubizza_num].to_s.empty?
      true
    else
      respond_with :message, text: 'Нельзя работать за двоих!!!'
      false
    end
  end

  def register_user(number)
    redis = Redis.new
    register_new_user(redis, number) if rubizza_num?(number) && number_free?(redis, number)
  end

  def number_free?(redis, number)
    if redis.get(number)
      respond_with :message, text: 'Этот номер закреплен за другим челом!!'
      false
    else
      true
    end
  end

  def rubizza_num?(number)
    all_rubizza_nums = YAML.load_file(FILE_WITH_NUMBERS)['numbers']
    if all_rubizza_nums.include?(number)
      true
    else
      respond_with :message, text: 'Нет такого номера!'
      false
    end
  end

  def register_new_user(redis, number)
    session[:telegram_id] = from['id']
    session[:rubizza_num] = number
    redis.set(number, session[:telegram_id])
    respond_with :message, text: 'Аккаунт зарегистрирован!'
  end
end
