require_relative '../helpers/user_helper.rb'

# module with start command
module StartCommand
  def start!(*)
    if UserHelper.registered(from['id'])
      respond_with :message, text: 'Sorry, but u have already registered!'
    else
      respond_with :message, text: 'Enter ur number'
      save_context :check_user
    end
  end

  def check_user(number = nil, *)
    if UserHelper.check_number(number) && UserHelper.find_user(number).empty?
      User.create(id: from['id'], number: number, in_camp: 'false')
      respond_with :message, text: 'Done!'
    else
      respond_with :message, text: 'Wrong number or user is registrated'
      save_context :start!
    end
  end
end
