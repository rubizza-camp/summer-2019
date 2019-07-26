module BotStartCommands
  NUMBERS_FILE = 'data/numbers.yaml'.freeze

  def start!(number = nil, *)
    if User.find(telegram_id: from['id'])
      respond_with :message, text: I18n.t(:start_fail)
    else
      check_number(number)
    end
  end

  private

  def check_number(number)
    if number
      validate_number(number)
    else
      save_context :start!
      respond_with :message, text: I18n.t(:enter_number)
    end
  end

  def validate_number(number)
    load_numbers_file
    if users_list.include?(number.to_i)
      register_user(number)
    else
      respond_with :message, text: I18n.t(:number_error)
    end
  end

  def users_list
    list = YAML.load_file(NUMBERS_FILE)
    list.values.to_a.slice(0)
  end

  def register_user(number)
    if User.find(camp_number: number)
      reply_with :message, text: I18n.t(:number_match)
    else
      user = User.create(telegram_id: from['id'], camp_number: number, status: STATUS[:out])
      session[:user_id] = user.id
      respond_with :message, text: I18n.t(:login_success)
    end
  end
end
