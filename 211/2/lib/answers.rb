module Answers
  def help
    'Type /checkin to checkin, '\
    '/checkout to checkout. '\
    'Sincerely yours, K.O.'\
  end

  def try_again
    'Try another number'
  end

  def gimme_id
    'Give me your id'
  end

  def ask_selfie
    'Selfie pls'
  end

  def ask_location
    "#{message.from.first_name}, where are you?"
  end
end
