# frozen_string_literal: true

module StartCommand
  YML_FILE = 'data/group.yml'

  attr_reader :peoples_number

  def start!(number = nil, *)
    @peoples_number = FileManager.read_yaml YML_FILE
    if User.all.select { |user| user.telegram_id == from['id'].to_s }.empty?
      number_check(number)
    else
      respond_with :message, text: 'У тебя есть уже код'
    end
  end

  private

  def number_check(number)
    if number
      exist_number(number)
    else
      save_context :start!
      respond_with :message, text: 'Введите ваш номер по лагерю'
    end
  end

  def exist_number(number)
    if @peoples_number.include?(number)
      exist_telegram_id(number)
    else
      save_context :start!
      reply_with :message, text: 'Этого кода не существует'
    end
  end

  def exist_telegram_id(number)
    if User.all.each { |user| user.number_in_camp.equal?(number) }
      reply_with :message, text: 'Этот номер занят'
    else
      add_person_id(number)
    end
  end

  def add_person_id(number)
    User.create(telegram_id: from['id'], number_in_camp: number, in_camp: 'false')
    DirectoryManager.create_directory("public/#{number}/checkins")
    DirectoryManager.create_directory("public/#{number}/checkouts")
    respond_with :message, text: 'Сделано'
  end
end
