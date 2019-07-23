module Answers
  def ask_photo
    { chat_id: message.chat.id, text: 'Need to see your photo first' }
  end

  def help
    text = %(Type /checkin to checkin,
/checkout to checkout.
/start to start.
Sincerely yours, K.O.)
    { chat_id: @message.chat.id,
      text:  text }
  end

  def try_again
    { chat_id: @message.chat.id, text: 'Try another number' }
  end

  def gimme_id
    { chat_id: @user_id, text: 'gimme your id' }
  end

  def ask_selfie
    { chat_id: @user_id, text: ' selfie pls' }
  end

  def ask_location
    { chat_id: message.chat.id, text: "#{message.from.first_name}, where are you?" }
  end
end
