module DeleteCommand
  def delete!(*)
    respond = 'You have\'t already registered'
    if student_registered?(student_number)
      redis.del(student_number)
      redis.del(payload['from']['id'])
      respond = 'Bye!'
    end
    respond_with :message, text: respond
  end
end
