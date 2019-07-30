require_relative '../helper_module/student_helper.rb'

module Start
  def start!(*)
    include StudentHelper

    if student_registered(from['id'])
      respond_with :message, text: t(:registered)
    else
      respond_with :message, text: t(:give_number)
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if student_entered_number_correctly(number)
      create_user(number)
      respond_with :message, text: t(:done)
    else
      respond_with :message, text: t(:start_error)
      save_context :start!
    end
  end
end
