module DeleteCommand
  def delete!(*)
    respond = 'You are not registered'
    return respond_with :message, text: respond unless redis.get(student_number)
    delete_from_redis
    respond = 'I deleted you'

    respond_with :message, text: respond
  end

  private

  def delete_from_redis
    redis.del(student_number)
    redis.del(payload['from']['id'])
  end
end
