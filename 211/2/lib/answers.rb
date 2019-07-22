module Answers
  def ask_photo
    { chat_id: message.chat.id, text: 'Need to see your photo first' }
  end

  def check_status
    REDIS.get("#{@user_id}_status")
  end

  def help
    { chat_id: @message.chat.id,
      text: 'Type /checkin to checkin, /checkout to checkout. Sincerely yours, K.O.' }
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

  def ask_something
    text = "I really don't understand you. May be you wanna /checkin, /checkout or get /help?"
    { chat_id: message.chat.id, text: text }
  end
end
