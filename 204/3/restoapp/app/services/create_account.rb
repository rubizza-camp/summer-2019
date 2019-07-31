class CreateAccount
  # :reek:FeatureEnvy
  def call(params)
    account_id = Account.all.last.id + 1
    Account.create!(
      id: account_id,
      name: params[:name],
      email: params[:email],
      password: hash_password(params[:password])
    )
  end

  private

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end
end
