require 'yaml'

DATA_PATH = './data/numbers.yaml'

module Start
  def start!(*)
    respond_with :message, text: "Enter your number in Rubizza Camp"
    save_context :register_message
  end

  def register_message(*message)
    number = message[0].to_i
    return response_if_redis_have_id_telegram if redis.get(user_id_telegram)
    return response_if_redis_have_number if redis.get(number)
    return response_if_number_in_the_list(number) if list_with_numbers.include?(number)
    response_in_other_situations
  end

  def response_if_redis_have_id_telegram
    respond = "You have already registered." +
      "Your number is #{redis.get(user_id_telegram)}." +
      "Use command /checkin or /checkout."
    respond_with :message, text: respond
  end

  def response_if_redis_have_number
    respond = 'Your number is registered. Use command /checkin or /checkout.'
    respond_with :message, text: respond
  end

  def response_if_number_in_the_list(number)
    registration(number)
    respond = 'Registration is done. Use command /checkin or /checkout'
    respond_with :message, text: respond
  end

  def response_in_other_situations
    respond_with :message, text: 'Sorry, try again'
    start!
  end

  def list_with_numbers
    YAML.load_file(DATA_PATH)['numbers'].map(&:to_i)
  end

  def registration(number)
    redis.set(user_id_telegram, number)
    redis.set(number, true)
  end
end
