module Start
  def start!(*)
    if redis.get('telegram_id').include?(from['id'].to_s)
      respond_with :message, text: "Я вас категорически приветствую! - #{redis.get(from['id'])}"
    else
      respond_with :message, text: 'Введи свой номер по лагерю'
      save_context :register_user
    end
  end
end
