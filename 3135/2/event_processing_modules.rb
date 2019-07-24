# Registration module process registration event
module Registration
  def self.start(user)
    user.action.registration
    user.request.camp_num
    'Provide camp number.'
  end

  # :reek:TooManyStatements
  def self.camp_num(user, camp_num)
    user.save.camp_num(camp_num)
    user.give_residency
    user.presence_init
    user.status_flush
    Utils.add_to_registered_list(camp_num)
    "You have been registered with camp number #{camp_num}.
 /checkin & /checkout commands are now available."
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

  # :reek:TooManyStatements
  def self.location(user, location)
    action = user.action.what?
    user.save.location(location)
    user.presence_switch
    user.status_flush
    Utils.store_session(user.id, action, user.photo_uri, location)
    "Location received. #{action.capitalize} successful."
  end
end
