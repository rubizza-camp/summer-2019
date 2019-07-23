module Answers
  def ask_photo
    'Need to see your photo first'
  end

  def help
    %(Type /checkin to checkin,
    /checkout to checkout.
    /start to start.
    Sincerely yours, K.O.)
  end

  def try_again
    'Try another number'
  end

  def gimme_id
    'gimme your id'
  end

  def ask_selfie
    ' selfie pls'
  end

  def ask_location
    "#{message.from.first_name}, where are you?"
  end
end
