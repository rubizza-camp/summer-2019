module FoolishMessageCatcher
  def message(*)
    respond_with :message, text: 'Я не знаю таких команд, напиши /start'
  end
end
