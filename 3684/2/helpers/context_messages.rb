module ContextMessages
  def photo
    if payload['photo']
      save_context :geo
      session[:photo_id] = payload['photo'].last['file_id']
      respond_with :message, text: I18n.t(:give_location)
    else
      save_context :photo
      respond_with :message, text: I18n.t(:wrong_photo_input)
    end
  end

  def geo
    if payload['location']
      save_data(payload['location'], session[:photo_id])
      respond_to_sucsess_checkin_or_checkout
    else
      save_context :geo
      respond_with :message, text: I18n.t(:wrong_geo_input)
    end
  end

  def add_new_user(number)
    if YAML.load_file('data/data.yml')['students'].delete('-').split(' ').include?(number.to_s)
      add_telegram_id(number)
      respond_with :message, text: I18n.t(:new_user_greeting)
    else
      respond_with :message, text: I18n.t(:wrong_camp_number)
    end
  end

  def register_user(number = nil)
    if number
      add_new_user(number)
    else
      respond_with :message, text: I18n.t(:wrong_camp_id_input)
      save_context :register_user
    end
  end
end
