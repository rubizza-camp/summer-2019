module Checkout
  def checkout!(*)
    return if not_registered?
    session[:type_of_operation] = 'checkouts'
    save_context :receive_photo_from_user
    respond_with :message, text: 'Пришли свое фото!!!'
  end
end
