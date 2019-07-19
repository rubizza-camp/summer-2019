class Timer
  def self.run(message)
    { chat_id: message.chat.id, text: time }
  end

  def self.time
    if adventure_time?
      'Adventure time!'
    else
      "it is #{Time.now}"
    end
  end

  def self.adventure_time?
    rand >= 0.5
  end
end