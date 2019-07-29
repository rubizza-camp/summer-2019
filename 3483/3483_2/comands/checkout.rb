require_relative '../check_helper/checker'
require_relative '../check_and_save/photo_location.rb'
# rubocop:disable Metrics/AbcSize
module Checkout
  include PhotoLocation

  def checkout!(*)
    if Checker.registered(from['id']) && Guest[from['id']].in_camp == 'checkout'
      check_data
      Guest[from['id']].update in_camp: 'checkin'
    else
      respond_with :message, text: t(:not_in_camp)
    end
  end
end
# rubocop:enable Metrics/AbcSize
