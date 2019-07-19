class LocationHelper
  attr_reader :bot, :message, :user_id, :latitude, :longitude, :photo
  
  def initialize(bot, message, user_id, photo)
    @bot = bot
    @message = message
    @user_id = user_id
    @latitude =  message.location.latitude
    @longitude = message.location.longitude
    @photo = photo
  end

  def call(status)
  	save_location(status)
  	puts @photo
    @photo.save_img(status) if @photo
  end

  def save_location(status)
    timestamp = Time.now.getlocal('+03:00').to_i
    puts timestamp
    loc = "#{@latitude}, #{@longitude}" 
    FileUtils.mkdir_p("#{user_id}/#{status}/#{timestamp}") 
    File.write("#{user_id}/#{status}/#{timestamp}/location.txt", loc)
  end

end
