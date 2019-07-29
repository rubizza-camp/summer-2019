require_relative '../check_helper/checker'
require_relative '../check_and_save/photo_location.rb'
module Checkin
  include PhotoLocation
  # rubocop:disable Metrics/AbcSize
  def checkin!(*)
    if Checker.registered(from['id']) && Guest[from['id']].in_camp == 'checkin'
      check_data
      Guest[from['id']].update in_camp: 'checkout'
    else
      respond_with :message, text: t(:in_camp)
    end
  end
end
# rubocop:enable Metrics/AbcSize
