require_relative '../helper_module/student_helper.rb'
require_relative '../check_and_save/photo_location.rb'

module Checkout
  include PhotoLocation
  include StudentHelper
  def checkout!(*)
    if student_registered(from['id']) && Student[from['id']].in_camp?
      check_data
      Student[from['id']].left_camp
    else
      respond_with :message, text: t(:not_in_camp)
    end
  end
end
