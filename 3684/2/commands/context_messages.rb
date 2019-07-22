module ContextMessages
  def photo(*)
    if payload['photo']
      save_context :geo
      session[:photo_id] = payload['photo'].last['file_id']
      respond_with :message, text: 'Теперь геолокацию'
    else
      save_context :photo
      respond_with :message, text: 'Скинь свое е.., лицо'
    end
  end

  def geo(*)
    if payload['location']
      save_data(payload['location'], session[:photo_id])
      respond_to_sucsess_checkin_or_checkout
    else
      save_context :geo
      respond_with :message, text: 'Я сказал скинь геолокацию'
    end
  end

  def add_new_user(number, *)
    if YAML.load_file('data/data.yml')['students'].delete('-').split(' ').include?(number.to_s)
      redis.set(from['id'], number)
      add_telegram_id
      respond_with :message, text: 'Заходи - не бойся, выходи - не плачь'
    else
      respond_with :message, text: ''
    end
  end

  def register_user(number = nil, *)
    if number
      add_new_user(number)
    else
      respond_with :message, text: 'Введи номер по лагерю, мудило'
      save_context :register_user
    end
  end
end
