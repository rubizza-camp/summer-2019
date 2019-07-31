class EmailUserService
  def self.chek_user_email(email)
    return true if User.find_by(['email = ? ', email])
  end
end
