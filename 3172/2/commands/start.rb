module StartCommand
  require 'yaml'

  # :reek:TooManyStatements
  def state_wait_id(message)
    user_id = message.from.id
    session_params = load_session_params(user_id)
    return 'You are already logged in.' if session_params
    session_params = { 'state' => 'start' }
    save_session(user_id, session_params)
    "Hello, #{message.from.first_name}. Enter your ID."
  end

  # :reek:TooManyStatements
  def srarting(message)
    rubizza_id = message.text
    user_id = message.from.id
    can_not_enter = verify_rubizza_id(rubizza_id)
    return can_not_enter if can_not_enter
    save_rubizza_id(user_id, rubizza_id, message)
    'Enter command /checkin or /checkout'
  end

  def verify_rubizza_id(rubizza_id)
    participants = YAML.safe_load(File.open('data/participants.yml'))['participants']
    return 'ID is not in the list' unless participants.include? rubizza_id.to_i
    session_is_busy = check_session(rubizza_id)
    session_is_busy ? session_is_busy : nil
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def save_rubizza_id(user_id, rubizza_id, message)
    session_params = load_session_params(user_id)
    session_params['rubizza_id'] = rubizza_id
    session_params['state'] = 'ready'
    session_params['check'] = 'checkout'
    save_session(user_id, session_params)
    user = message.from.first_name
    add_user(rubizza_id, user)
  end
end
