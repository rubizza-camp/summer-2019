require 'time'
module CheckoutCommand
  def checkout!(*)
    if User[from['id']].is_checkin
      if payload['photo']
        respond_with :message, text: "Принял фото, терь гео"
        FileManager.request_file_path(payload['photo'].last['file_id'], User[from['id']].person_number, 'checkouts')
        save_context :checkout!
      elsif payload['location']
        respond_with :message, text: "Хорошего дня"
        FileManager.save_location_in_file(payload['location'],User[from['id']].person_number, 'checkouts')
        User[from['id']].update(checkout_datetime: Time.now, is_checkin: false)
      else
        respond_with :message, text: 'Кинь фотку'
        save_context :checkout!
      end
    else
      respond_with :message, text: "Еще даже не принял смену, а уже уходишь?"
    end
  end
end