module Answers

  def ask_photo
    { chat_id: message.chat.id, text: 'Need to see your photo first' }
  end

end