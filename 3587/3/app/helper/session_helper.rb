module SessionHelper
  def start_session
    session_start!
    session['user_id'] = @user.id
    redirect '/'
  end
end
