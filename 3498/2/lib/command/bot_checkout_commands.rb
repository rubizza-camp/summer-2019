module BotCheckoutCommands
  def checkout!
    if session[:is_in?]
      session[:is_in?] = false
    else
      respond_with :message, text: 'First of all, try to /checkin'
    end

    respond_with :message, text: 'See you later!'
    create_directory
  end

  private

  def create_directory
    path = "public/#{session[:id]}/checkouts/#{Time.now.strftime('%a, %d %b %Y %H:%M')}"
    FileUtils.mkdir_p(path)
  end
end
