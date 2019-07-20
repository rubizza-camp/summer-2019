module Checkin
  def checkin!(*)
    session[:type_of_operation] = 'checkins'
    save_context :ask_for_photo_checkin
    respond_with :message, text: 'Скинь свое лицо!!!'
  end
end
