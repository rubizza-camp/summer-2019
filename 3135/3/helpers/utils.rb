module Utils
  def set_active_user(id)
    return User.find(id) if id

    nil
  end

  def login(email,password)
    if User.exists?(email: email) && User.find_by(email: email)[:password] == password
      session[:id] = User.find_by(email: email)[:id]
      redirect session[:return_to_page]
    else
      flash.next[:notice] = 'wrong input'
      redirect '/login'
    end
  end
end
