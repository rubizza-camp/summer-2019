module HelpMethods
  def registred?
    session.key?(:number)
  end

  def user_id
    payload['from']['id']
  end

  def photo?
    payload['photo']
  end

  def geo?
    payload['location']
  end
end
