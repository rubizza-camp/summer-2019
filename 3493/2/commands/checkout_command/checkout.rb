require_relative '../../lib/user_methods'

module CheckoutCommand
  def checkout!(*)
    if UserMethods.registered?(from['id']) && UserMethods.checkin?(from['id'])
      respond_with :message, text: 'Пришли фото'
      session['status'] = 'checkouts'
      save_context :selfie
    else
      respond_with :message, text: 'Сначала выполни команду /checkin!'
    end
  end
end
