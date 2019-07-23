# Registration module process registration event
module Registration
  def self.start(user)
    user.action.registration
    user.request.camp_num
    'Provide camp number.'
  end

  def self.camp_num(user, camp_num)
    user.save.camp_num(camp_num)
    user.give_residency
    user.presence_init
    user.status_flush
    "You have been registered with camp number #{camp_num}."
  end
end

# Registration module process checkin/checkout event
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
    "Checkout initiated. #{user.action.what?.capitalize} step 1: Send photo."
  end

  def self.photo(user, uri)
    user.save.photo_uri(uri)
    user.request.location
    "Photo received. #{user.action.what?.capitalize} step 2: Send location."
  end

  def self.location(user, location)
    user.save.location(location)
    user.presence_switch
    action = user.action.what?
    Utils.store_session(user.id, action, user.photo_uri, user.location)
    user.status_flush
    "Location received. #{action.capitalize} successful."
  end
end
