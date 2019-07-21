module Registration
  def self.start(user)
    user.action.registration
    user.request.camp_num
    'Provide camp number.'
  end

  def self.camp_num(user)
    @save.camp_num
    @user.give_residency
    @user.presence_init
    @user.action.flush
    @user.request.flush
    send_message("You have been registered with camp number #{@message.text}.")
  end
end

#module Respond
#  def self.custom(line)
#
#    
#  end
#
#    
#end