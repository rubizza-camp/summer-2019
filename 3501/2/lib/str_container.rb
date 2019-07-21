# frozen_string_literal: true

class StrContainer
  def self.send_yourself_pic
    'Пришли мне себяшку!'
  end

  def self.truly_here
    'Точно на месте?'
  end

  def self.god_luck
    'Удачи!'
  end

  def self.check_out_help
    'И незабудь /checkout когда закончишь...'
  end

  def self.good_rest
    'Удачного отдыха!'
  end

  def self.welcome_new
    'Привет незнакомец, введи свой номер Rubizza club.'
  end

  def self.welcome_old(user_name)
    "Привет, #{user_name}. Рад видеть вас снова!"
  end

  def self.registred_new(user_name)
    "Добро пожаловать, #{user_name} в Rubizza survival camp!"
  end

  def self.welcome
    'Привет, . Рад видеть вас снова!'
  end

  def self.busy_user_name
    'Вы ошиблись, номер уже занят!'
  end

  def self.need_number
    'Необходим ваш номер!'
  end

  def self.number_not_consist
    'Номер не найден!'
  end

  def self.session_unclosed
    'У вас есть незакрытая сессия! /checkout - для закрытия'
  end

  def self.session_allclosed
    'Откройте сессию! /checkin - для открытия'
  end

  def self.more_data
    'Неправильный ввод, попробуйте ещё раз!'
  end

  def self.new_start
    'Привет, для начала введите /start!'
  end
end
