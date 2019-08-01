require_relative '../helper_module/student_helper.rb'
require_relative '../check_and_save/photo_location.rb'

module Checkin
  include PhotoLocation
  include StudentHelper
  def checkin!(*)
    if student_registered(from['id']) && Student[from['id']].not_in_camp?
      check_data
      Student[from['id']].into_camp
    else
      respond_with :message, text: t(:in_camp)
    end
  end
end
