require_relative '../check_and_save/checker'

module Start
  def start!(*)
    if Checker.registered(from['id'])
      respond_with :message, text: t(:registered)
    else
      respond_with :message, text: t(:give_number)
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if Checker.new(number).correct_data?
      Guest.create(id: from['id'], number: number, in_camp: 'false')
      respond_with :message, text: t(:done)
    else
      respond_with :message, text: t(:start_error)
      save_context :start!
    end
  end
end
