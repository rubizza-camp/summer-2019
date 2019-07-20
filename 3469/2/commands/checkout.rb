module Checkout
  def checkout!(*)
    session[:type_of_operation] = 'checkouts'
    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Скинь свое лицо!!!'
  end
end
