module Help
  def help!(*)
    respond_with :message, text: "Добро пожаловать в Ruby Survival Camp 2019!\nОписание доступных
    команд:\n  -- /start - Начать работу с ботом\n  -- /checkin - Принять смену\n  -- /checkout -
    Сдать смену\n  -- /help - краткий FAQ\n  -- /logout - На случай, если вы случайно залогинились
    НЕ ПОД СВОИМ НОМЕРОМ"
  end
end
