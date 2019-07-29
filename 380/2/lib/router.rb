# routing answers
module Router
  # :reek:TooManyStatements
  def self.resolve(message, bot)
    tg_id = message.from.id
    case message.text
    when '/start' then Start.new(tg_id).call
    when '/check_in' then CheckIn.new(tg_id).call
    when '/check_out' then CheckOut.new(tg_id).call
    when '/help' then '/start for get camp_id, /check_in for check in, /check_out for check out'
    else
      operation_by_user_status(message, bot)
    end
  end

  # :reek:TooManyStatements, :reek:DuplicateMethodCall
  def self.operation_by_user_status(message, bot)
    tg_id = message.from.id
    user = User.find(tg_id)
    user_status = user.status.to_s
    if user_status.to_sym == :waiting_for_number
      Register.new(tg_id).call(message.text.to_i)
    elsif (user_status.include? 'waiting_for_selfie') && !message.photo.empty?
      Selfie.new(tg_id).call(bot.api.get_file(file_id: message.photo.last.file_id))
    elsif (user_status.include? 'waiting_for_geo') && message.location
      Geo.new(tg_id).call(message.location)
    end
  end
end
