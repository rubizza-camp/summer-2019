require './helpers/path_helper'

module CheckOut
  include PathHelper

  def checkout!(*)
    if registred?
      leave_camp_time
      save_context :checkout_photo
      respond_with :message, text: 'Send a selfie'
    else
      respond_with :message, text: 'You did not authorize'
    end
  end

  def checkout_photo(*)
    if valid_photo?
      save_photo(checkout_dir)
      save_context :checkout_position
      respond_with :message, text: 'Send your geoposition'
    else
      save_context :checkout_photo
      respond_with :message, text: 'Please send a selfie!'
    end
  end

  def checkout_position(*)
    if correct_geoposition?
      save_geoposition(checkout_dir)
      respond_with :message, text: 'Check-out successful'
    else
      save_context :checkout_position
      respond_with :message, text: 'Please send a geoposition!'
    end
  end
end
