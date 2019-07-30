class SignIn
  def call(_session, params)
    account = Account.find(params[:email])
    if validate?(account, params[:password])
      { success: true, payload: account }
    else
      { success: false }
    end
  end

  private

  def validate_password(hash_password, password)
    BCrypt::Password.new(hash_password) == password
  end

  def validate?(account, password)
    account.present? && validate_password(account.password, password)
  end
end
