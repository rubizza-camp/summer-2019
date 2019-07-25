require_relative 'utils'

# Reception module process checkin/checkout event
module Reception
  def self.checkin(user)
    user.action.checkin
    user.request.photo
    'Checkin initiated. Step 1: Send photo.'
  end

  # :reek:DuplicateMethodCall:
  def self.checkout(user)
    user.action.checkout
    user.request.photo
    "Checkout initiated. #{user.action.value.capitalize} step 1: Send photo."
  end

  def self.photo(user, uri)
    user.save_photo_uri(uri)
    user.request.location
    "Photo received. #{user.action.value.capitalize} step 2: Send location."
  end

  # :reek:TooManyStatements
  def self.location(user, location)
    action = user.action.value
    user.save_location(location)
    user.presence_switch
    user.status_flush
    Utils.store_session(user.id, action, user.photo_uri, location)
    "Location received. #{action.capitalize} successful."
  end
end
