module MessagesHelper
  def show_message_about_problems
    flash[:danger] = 'Error'
    redirect env['HTTP_REFERER']
  end
end
