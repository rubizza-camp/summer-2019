# start bot
module Start
  def start!
    check = from['id'].to_s + 'check'
    redis = Redis.new(host: 'localhost')
    redis.set(check, 0)
    respond_with :message, text: 'Дарова!'
    respond_with :message, text: 'Напиши свой номер и да начнётся флекс'
  end
end
