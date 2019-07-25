require_relative 'utils'

# Registration module process registration event
module Registration
  def self.start(user)
    user.action.registration
    user.request.camp_num
    'Provide camp number.'
  end

  # :reek:TooManyStatements
  def self.camp_num(user, camp_num)
    user.save_camp_num(camp_num)
    user.give_residency
    user.presence_init
    user.status_flush
    Utils.add_to_registered_list(camp_num)
    "You have been registered with camp number #{camp_num}.
 /checkin & /checkout commands are now available."
  end
end
