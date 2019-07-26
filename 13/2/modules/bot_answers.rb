# frozen_string_literal: true

module BotAnswers
  RESPONSES = {
    wait_start: 'Hey, push /start',
    wait_number: 'You pushed start, lets enter your number',
    number_incorrect: 'This incorrect, enter correct number',
    wait_checkin: 'Your number is ok, push /checkin',
    wait_location: 'You checked in, need location',
    wait_photo: 'Your location received, wait for your photo',
    wait_checkout: 'Your photo and location received, you may /checkout',
    wait_checkout_location: 'You pushed checkout, let me see you location',
    wait_checkout_photo: 'Then, for checkout we need your photo'}

  def self.put_message(bot, message, answer)
    bot.api.send_message(chat_id: message.chat.id, text: answer)
  end
end
