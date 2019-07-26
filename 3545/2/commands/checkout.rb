# frozen_string_literal: true

module CheckOutCommand
  include Telegram::Bot::UpdatesController::MessageContext

  def checkout!
    session[:is_checkedin?] = false
    FileUtils.mkdir_p(checkout_path) unless File.exist?(checkout_path)

    respond_with :message, text: 'Вы вышли из кемпа'
  end

  def checkout_path
    "public/#{chat['id']}/checkout/#{Time.now.strftime('%a, %d %b %Y %H:%M')}"
  end
end
