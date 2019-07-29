require_relative '../helper_modules/auth'
require_relative '../helper_modules/user'

module StartCommand
  include Authorization
  def start!(*)
    respond_with :message, text: "Добро пожаловать, #{from['first_name']}"
    if already_registered?
      already_registered_warning(user_with_current_id.first.camp_id)
    else
      user_registration
    end
  end
end
