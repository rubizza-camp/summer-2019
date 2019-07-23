require 'redis'
require_relative 'help_methods'

module StartCommand
  include HelpMethods

  def start!(*)
    if registred?
      respond_with :message, text: "Вы уже вошли под: #{session[:number]}"
    else
      save_context :register_from_message
      respond_with :message, text: 'Введите ваш номер:'
    end
  end

  def register_from_message(*words)
    respond_with :message, text: register_session(words)
  end

  private

  def register_session(number = nil, *)
    redis = Redis.new
    check_registaration(redis, number.first.to_i)
  rescue NoMethodError
    save_context :register_from_message
    respond_with :message, text: 'Что-то пошло не так, попробуйте еще раз:'
  end

  def check_registaration(redis, number)
    if !member?(number)
      'Данный номер отсутсвует. Попробуйте еще раз'
    elsif redis.get(number) || session.key?(:number)
      'Вы уже зарегестрированны'
    else
      session[:number] = number
      redis.set(number, user_id)
      'Регистрация прошла успешно'
    end
  end

  def member?(number)
    members.include?(number)
  end

  def members
    @members ||= YAML.load_file('members.yml')['members']
  end
end
