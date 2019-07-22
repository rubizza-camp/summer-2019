require_relative '../../support_methods/user_methods/user_methods.rb'

module CheckoutCommand
  def checkout!(*)
    if UserMethods.registered?(from['id']) && UserMethods.checkin?(from['id'])
      respond_with :message, text: 'Фоточку в студию'
      session['status'] = 'checkouts'
      save_context :selfi
    else
      respond_with :message, text: 'А ты точно сегодня чекинился??'
    end
  end
end
