module Help

  def help!(*)
    #добписать дабы использовать надо залогиньться
    respond_with :message, text: 'Here is a list of allowed commands: /start, /checkin and /checkout.'
  end
    
end
