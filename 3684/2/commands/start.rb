module Start
  def start!
    if redis.get('telegram_id').include?(from['id'].to_s)
      respond_with :message, text: I18n.t(:old_user_greeting)
    else
      respond_with :message, text: I18n.t(:input_camp_id)
      save_context :register_user
    end
  end
end
