module Unlink
  def unlink!(*)
    respond_with :message, text: 'Отвязать номер от аккаунта?', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Удалить', callback_data: 'unlink_confirmed' },
          { text: 'Отмена', callback_data: 'unlink_denied' }
        ]
      ]
    }
  end

  private

  def delete(data)
    return unless data == 'unlink_confirmed'

    @redis.del(session[:rubizza_num])
    session[:rubizza_num] = nil
    respond_with :message, text: "#{data}. /start чтобы зарегистрироваться"
  end
end
