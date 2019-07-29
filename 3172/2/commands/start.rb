module Start
  require 'yaml'
  require 'json'

  def self.fetch_id(user)
    case user.state
    when 'initial'
      user.state = 'start'
      'Hello. Enter your ID.'
    when 'stop'
      user.state = 'ready_checkin'
      'Enter command /checkin'
    else 'You are already logged in.'
    end
  end

  # :reek:TooManyStatements
  def self.logging_in(user, message)
    rubizza_id = message.text
    can_not_enter = verify_rubizza_id(rubizza_id)
    return can_not_enter if can_not_enter
    save_rubizza_id(rubizza_id, message.from.first_name)
    user.rubizza_id = rubizza_id
    user.state      = 'ready_checkin'
    'Enter command /checkin'
  end

  def self.verify_rubizza_id(rubizza_id)
    participants = YAML.safe_load(File.open('data/participants.yml'))['participants']
    return 'ID is not in the list' unless participants.include? rubizza_id.to_i
    session_is_busy(rubizza_id)
  end

  def self.session_is_busy(rubizza_id)
    list_of_logged_in = Redis.current.get('list_of_logged_in')
    if list_of_logged_in
      list_of_logged_in = JSON.parse(list_of_logged_in)
      if list_of_logged_in[rubizza_id]
        logged_in = "#{list_of_logged_in[rubizza_id]} already logged in under #{rubizza_id}"
      end
    else
      Redis.current.set('list_of_logged_in', {}.to_json)
    end
    logged_in
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def self.save_rubizza_id(rubizza_id, user)
    list_of_logged_in = JSON.parse(Redis.current.get('list_of_logged_in'))
    list_of_logged_in[rubizza_id] = user
    Redis.current.set('list_of_logged_in', list_of_logged_in.to_json)
  end
end
