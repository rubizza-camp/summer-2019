require 'time'
require_relative 'kids_checker'
require_relative 'photo_location.rb'

module Checkout
  include PhotoLocation

  def checkout!(*)
    if KidsChecker.registered(from['id']) && Gest[from['id']].in_camp == 'true'
      check_data
      Gest[from['id']].update in_camp: 'false'
    else
      respond_with :message, text: 'U not in camp'
    end
  end
end