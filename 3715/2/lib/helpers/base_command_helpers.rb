module BaseCommandHelpers
  private

  def member_exist?(answer)
    STUDENT_LIST.include?(answer.to_i)
  end

  def member_is_registered?
    session.key?(:number)
  end

  def file_path_preparation
    "./public/#{session[:number]}/#{session[:status]}s/#{session[:time]}/"
  end
end
