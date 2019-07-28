module MessagesHelper

  def invalid_password
    flash[:danger] = 'Invalid user password!!!!!!!!'
    redirect 'sign_in'
  end

  def no_email_in_db
    flash[:danger] = 'We can not find you email!!!!!!!!'
    redirect 'sign_in'
  end

  def invalid_email
    flash[:danger] = 'Invalid email!!!!!!!!'
    redirect 'sign_up'
  end

  def password_should_be_the_same
    flash[:danger] = 'Password should be the same as confirm password!!!!!!!!'
    redirect 'sign_up'
  end

  def already_registered
    flash[:danger] = 'This email is already registered!!!!!!!!'
    redirect 'sign_in'
  end

end
