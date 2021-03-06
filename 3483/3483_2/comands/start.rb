require_relative '../helper_module/student_helper.rb'

module Start
  include StudentHelper
  def start!(*)
    if student_registered(from['id'])
      respond_with :message, text: t(:registered)
    else
      respond_with :message, text: t(:give_number)
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if student_entered_number_correctly?(number)
      Student.create(id: from['id'], number: number, status: 'checkin')
      respond_with :message, text: t(:done)
    else
      respond_with :message, text: t(:start_error)
      save_context :start!
    end
  end
end
