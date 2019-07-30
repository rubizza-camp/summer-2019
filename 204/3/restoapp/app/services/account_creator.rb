class AccountCreator
  attr_reader :id, :name, :email, :password

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @email = params[:email]
    @password = hash_password(params[:password])
  end

  def call
    account_id = Account.all.last.id + 1
    Account.create!(
      id: account_id,
      name: name,
      email: email,
      password: password
    )
  end

  private

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end
end
