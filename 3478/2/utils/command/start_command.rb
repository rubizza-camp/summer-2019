require 'redis'
require_relative '../file_manager'

module StartCommand
  include FileManager

  def start!(number = nil, *)
    return unless new_user?

    guide unless session.key?(:first_time)
    if number
      register_user(number)
    else
      save_context :start!
      respond_with :message, text: '📝 Введите свой номер'
    end
  end

  private

  def guide
    respond_with :message, text: 'Это бот для трекинга времени, проведенного в Rubizza Camp'
    respond_with :message, text: "Основные комманды /checkin и /checkout\n"\
                                 "Если что-то пошло не так введи /unlink и /start\n"
    respond_with :message, text: 'Теперь нужно зарегестрироваться'
    session[:first_time] = false
    save_context :start!
  end

  def register_user(number)
    register_new_user(number) if rubizza_num?(number) && number_free?(number)
  end

  def new_user?
    new_user = !session.key?(:rubizza_num)
    respond_with :message, text: '🚫 К этому аккаунту уже привязан номер. [/unlink]' unless new_user
    new_user
  end

  def number_free?(number)
    num = @redis.get(number)
    respond_with :message, text: '🚫 Этот номер занят другим пользователем' if num
    !num
  end

  def rubizza_num?(number)
    return true if YAML.load_file(ENV['YML_FILE'])['all_rubizza_nums'].include?(number.to_i)

    respond_with :message, text: '🚫 Неправильный номер'
    false
  end

  def register_new_user(number)
    session[:rubizza_num] = number
    session[:telegram_id] = from['id']
    @redis.set(number, from['id'])
    respond_with :message, text: '✅ Аккаунт успешно зарегистрирован'
  end
end
