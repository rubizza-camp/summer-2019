module Unlink
  def unlink!(message = nil, *)
    if valid_message(message)
      delete
    else
      respond_with :message, text: "Отвязать номер от своего аккаунта?\n[ Да | Нет ]"
      save_context :unlink!
    end
  end

  private

  def valid_message(message)
    message =~ /(Да)|(да)|(Yes)|(yes)/
  end

  def delete
    redis = Redis.new
    redis.del(session[:rubizza_num])
    session[:rubizza_num] = nil
    respond_with :message, text: 'Номер отвязан. /start чтобы зарегистрироваться'
  end
end
