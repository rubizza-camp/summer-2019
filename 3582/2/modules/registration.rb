require 'yaml'
module Registration
  def check_registration(group_id)
    if could_register?(group_id) && !registered?(group_id)
      register(group_id)
      respond_with :message, text: 'Теперь ты зарегистрирован(начать смену /checkin)'
    elsif registered?(group_id)
      respond_with :message, text: 'Пользователь с таким номером уже зарегестрирован(/start)'
    else
      respond_with :message, text: 'Тебя нет в списках, попробуй снова(/start)'
    end
  end

  private

  def register(group_id)
    @db.sadd('registered_users', group_id)
    session[:telegram_id] = session_key
    session[:group_id] = group_id
    session[:registered] = true
  end

  def registered?(group_id)
    @db.smembers('registered_users').include? group_id
  end

  def could_register?(group_id)
    group_ids = YAML.load_file('data.yml').dig('students').map!(&:to_s)
    group_ids.include? group_id
  end
end
