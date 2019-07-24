module Registration
  def check_registration(group_id)
    group_ids = YAML.load_file('data.yml').dig('students').map!(&:to_s)
    if group_ids.include?(group_id)
      respond_with :message, text: 'Теперь ты зарегистрирован'
      register(group_id)
    else
      respond_with :message, text: 'Тебя нет в списках'
    end
  end

  def register(group_id)
    session[:telegram_id] = session_key
    session[:group_id] = group_id
    session[:is_registered] = true
  end
end
