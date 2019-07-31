class CookiesService
  def self.add_user_info_to_cookies(email)
    user = User.where(['email = ?', email]).first
    cookies[:users_id] = user[:id]
    cookies[:user_name] = user[:name]
  end

  def self.delete_cookies(*keys)
    keys.each { |key| cookies.delete(key) }
  end
end
