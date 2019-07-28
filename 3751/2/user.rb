require 'yaml'

class User
  include RedisHelper

  def call(message)
    if message.text == '/start'
      'Hello. Enter your id'
    elsif rubizzians.include?(message.text.to_i)
      save_session('camp_id', message)
      'you entered, press /checkin'
    else
      'Enter right id'
    end
  end

  # :reek:UtilityFunction
  def rubizzians
    users = YAML.load_file('users.yaml')
    users['id']
  end
end
