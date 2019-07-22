module StopCommand
  def stop(user_id)
    session_params = load_session_params(user_id)
    return 'You have not even started' unless session_params
    delete_users(user_id)
    'Bye, bye'
  end
end
