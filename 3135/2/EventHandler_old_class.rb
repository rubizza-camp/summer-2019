# Handles all sorts of events =)
class EventHandler2
  def initialize(bot, message)
    @bot = bot
    @message = message

    tg_id = @message.from.id
    @user = User.new(tg_id)
    #@save = DataSaver.new(@user)

  end

  # -respond to user
  #def send_message(line)
  #  @bot.api.send_message(chat_id: @message.chat.id, text: line)
  #end

  #def send_negative(line)
  #  @bot.api.send_message(chat_id: @message.chat.id, text: "Unexpected input (#{line.to_str}).")
  #end
  # -----------------

  def start
    if @user.resident?
      send_message('You are already registered.')
    else
      @user.action.registration
      @user.request.camp_num
      send_message('Provide camp number.')
    end
  end

  def camp_num
    if @user.action.registration? && @user.request.camp_num?
      camp_num = @message.text
      @save.camp_num
      @user.give_residency
      @user.presence_init
      @user.action.flush
      @user.request.flush
      send_message("You have been registered with camp number #{@message.text}.")
    else
      send_negative(__method__)
    end
  end
# ========================

  def checkin
    if @user.resident? && !@user.present?
      @user.action.checkin
      @user.request.photo   
      send_message('Send photo.')
    else
      send_negative(__method__)
    end
  end

  def checkout
    if @user.resident? && @user.present?
      @user.action.checkout
      @user.request.photo    
      send_message('Send photo.')
    else
      send_negative(__method__)
    end
  end

  #========================

  def photo
    if @user.request.photo?
  
      # -prep photo uri
      large_file_id = @message.photo.last.file_id
      file = @bot.api.get_file(file_id: large_file_id)
      file_path = file.dig('result', 'file_path')
      uri = "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
      # -

      @save.photo_uri(uri)
      @user.request.location
      send_message('Photo received. Send location.')
    else
      send_negative(__method__)
    end  
  end

# ======================

  def location
    if @user.request.location?

      # -prep location 
      lat = @message.location.latitude.to_s
      long = @message.location.longitude.to_s
      # -
  
      @save.location(lat, long)
      @user.presence_switch

      action = @user.action.what?
      @user.action.flush
      @user.request.flush
      send_message("#{action.capitalize} successful.")
    else
      send_negative(__method__)
    end  
  end

  def status
    puts @user.action.what?
    puts @user.request.what?
    puts @user.present?
  end
end