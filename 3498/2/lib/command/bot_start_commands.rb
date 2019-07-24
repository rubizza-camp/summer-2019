module BotStartCommands
  attr_reader :users_list

  def start!(number = nil, *)
    if User.all.select { |user| user.telegram_id == from['id'].to_s }.empty?
      check_number(number)
    else
      respond_with :message, text: 'You have already started your journey'
    end
  end

  private

  def check_number(number)
    if number
      validate_number(number)
    else
      save_context :start!
      respond_with :message, text: 'Enter your number'
    end
  end

  def validate_number(number)
    load_numbers_file
    if @users_list.include?(number.to_i)
      register_user(number)
    else
      respond_with :message, text: 'Invalid number! Type /start and try again'
    end
  end

  def load_numbers_file
    list = YAML.load_file('data/numbers.yaml')
    @users_list = list.values.to_a.slice(0)
  end

  def register_user(number)
    if User.all.each { |user| user.camp_number.equal?(number) }
      reply_with :message, text: 'It is not your number! Type /start and try again'
    else
      User.create(telegram_id: from['id'], camp_number: number)
      session[:id] = number
      respond_with :message, text: 'Now we are watching you'
    end
  end
end
