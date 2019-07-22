module Session
  require 'json'
  require 'redis'

  # :reek:UtilityFunction
  def save_session(user_id, session_params)
    Redis.new.set(user_id, session_params.to_json)
  end

  # :reek:UtilityFunction
  def load_session_params(user_id)
    session_params = Redis.new.get(user_id)
    session_params ? JSON.parse(session_params) : nil
  end

  # :reek:UtilityFunction
  # :reek:TooManyStatements
  def delete_users(user_id)
    db = Redis.new
    session_params = db.get(user_id)
    user = session_params['rubizza_id']
    list_of_logged_in = JSON.parse(db.get('list_of_logged_in'))
    list_of_logged_in.delete(user)
    db.set('list_of_logged_in', list_of_logged_in.to_json)
    db.del(user_id)
  end

  # :reek:UtilityFunction
  def check_session(rubizza_id)
    list_of_logged_in = Redis.new.get('list_of_logged_in')
    if list_of_logged_in
      list_of_logged_in = JSON.parse(list_of_logged_in)
      if list_of_logged_in[rubizza_id]
        logged_in = "#{list_of_logged_in[rubizza_id]} already logged in under #{rubizza_id}"
      end
    else
      Redis.new.set('list_of_logged_in', {}.to_json)
    end
    logged_in
  end

  # :reek:UtilityFunction
  def add_user(rubizza_id, user)
    db = Redis.new
    list_of_logged_in = JSON.parse(db.get('list_of_logged_in'))
    list_of_logged_in[rubizza_id] = user
    db.set('list_of_logged_in', list_of_logged_in.to_json)
  end
end
