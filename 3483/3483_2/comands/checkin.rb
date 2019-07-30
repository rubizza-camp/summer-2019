require_relative '../helper_module/student_helper.rb'
require_relative '../check_and_save/photo_location.rb'

module Checkin
  include PhotoLocation
  include StudentHelper
  # rubocop:disable Metrics/AbcSize
  def checkin!(*)
    if student_registered(from['id']) && not_in_camp_now
      check_data
      came_to_camp
    else
      respond_with :message, text: t(:in_camp)
    end
  end
end
# rubocop:enable Metrics/AbcSize
