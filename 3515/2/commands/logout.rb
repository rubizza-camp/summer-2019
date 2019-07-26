require_relative '../helper_modules/helper'

module Logout
  include Helper
  def logout!(*)
    if !current_user.to_s.empty?
      current_user.delete
      respond_with :message, text: I18n.t(:logout_success)
    else
      respond_with :message, text: I18n.t(:logout_failed)
    end
  end
end
