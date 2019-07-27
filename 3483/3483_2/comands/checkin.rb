require_relative '../check_and_save/checker'
require_relative '../check_and_save/photo_location.rb'

module Checkin
  include PhotoLocation

  def checkin!(*)
    if Checker.registered(from['id']) && Guest[from['id']].in_camp == 'false'
      check_data
      Guest[from['id']].update in_camp: 'true'
    else
      respond_with :message, text: t(:in_camp)
    end
  end
end
