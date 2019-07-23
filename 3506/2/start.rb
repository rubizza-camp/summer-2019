require_relative 'user'

module Start
  def start!(*)
    if User.registered?(from['id'])
      respond_with :message, text: 'Регистрироваться второй раз нельзя, вредина.'
    else
      respond_with :message, text: 'Напиши свой номер!'
    end
  end

  def message(user_message)
    student_number = user_message['text']
    error = User.validate_student_number(student_number)
    if error
      respond_with :message, text: error
    else
      User.create_student(user_message['from']['id'], student_number)
      respond_with :message, text: 'Введите команду.'
    end
  end
end
