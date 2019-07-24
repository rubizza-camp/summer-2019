class Dialog < Conversation
  def valid?
    true
  end

  def call
    case user_said
    when '/start'
      ::Start.call(self)
    when '/check_in'
      ::CheckIn.call(self)
    when '/check_out'
      ::CheckOut.call(self)
    when '/help'
      ::Help.call
    else
      operation_by_user_status(user_said)
    end
  end

  def operation_by_user_status(message)
    user = User.find(message.from.id)
    case user.action_status
    when 'register_process'
      ::Register.call(self)
    when 'in_selfie'
      ::Selfie.call(self)
    when 'in_geo'
      ::Geo.call(self)
    end
  end
end
