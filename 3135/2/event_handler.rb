class EventHandler
  def self.call(bot, message)
    new(bot, message).call
  end

  def initialize(bot, message)
    @bot = bot
    @message = message
    @user = User.new(message.from.id)
  end

  def call
    case @message.text
    when '/start'
      if @user.resident?
        'You are already registered.'
      else
        Registration.start(@user)
      end
    #when /^\d+$/
    #  if @user.action.registration? && @user.request.camp_num?
        
    
#      end    
    # event.camp_num
    #when '/checkin'
    # event.checkin
    #when '/checkout'
    # event.checkout
    when '/status'
      #puts @user.action.what?
      #puts @user.request.what?
      #puts @user.present?
    #else
    #  case
    #  when @message.photo.any?
    #    event.photo
    #  when @message.location 
    #    event.location
    else
        'wrong input main switch'
      end
    #end
  end

      # -----------------
end