module Stop
  def self.stop(user)
    return 'You have not even started' unless user.state
    user.state = 'stop'
    user.photo = nil
    user.location = nil
    'Bye, bye'
  end
end
