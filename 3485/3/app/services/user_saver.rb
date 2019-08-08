class UserSaver < Base
  def call
    user = User.new(name: name, email: email, password: password,
                    password_confirmation: password_confirmation)
    return error(user) if user.invalid?

    user.password = BCrypt::Password.create(password)
    user.save(validate: false)
    success(user)
  end

  private

  attr_reader :name, :email, :password, :password_confirmation

  def initialize(name:, email:, password:, password_confirmation:)
    @name = name
    @email = email.downcase
    @password = password
    @password_confirmation = password_confirmation
  end
end
