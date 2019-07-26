module BaseCommandHelpers
  private

  def member_exist?(answer)
    STUDENT_LIST.include?(answer.to_i)
  end

  def member_is_registered?
    session.key?(:number)
  end

  def not_registered
    respond_with :message, text: NOT_REGISTERED_MESSAGE unless member_is_registered?
  end

  def registered
    respond_with :message, text: ALREADY_REGISTERED_MESSAGE if member_is_registered?
  end

  def alredy_checkined
    respond_with :message, text: ALREADY_CHECKINED_MESSAGE unless session[:state] == 'checkin'
  end

  def alredy_checkouted
    respond_with :message, text: ALREADY_CHECKOUTED_MESSAGE unless session[:state] == 'checkout'
  end

  def file_path_preparation
    "./public/#{session[:number]}/#{session[:state]}s/#{session[:time]}/"
  end
end
