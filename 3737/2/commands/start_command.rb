require_relative '../helpers/user_helper.rb'

# module with start command
module StartCommand
  def start!(*)
    if User.registered?(from['id'])
      respond_with :message, text: 'Sorry, but you have already registered!'
    else
      respond_with :message, text: 'Enter your number'
      save_context :registering_user
    end
  end

  def registering_user(number = nil, *)
    if UserHelper.existed_numbers(number) && !User.find(number: number)
      User.create(id: from['id'], number: number, in_camp: 'false')
      respond_with :message, text: 'Done!'
    else
      respond_with :message, text: 'Wrong number or user is registrated'
      save_context :start!
    end
  end
end
