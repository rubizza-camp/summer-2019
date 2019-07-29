module DeleteCommand
  def delete!(*)
    return respond_with :message, text: NOT_REGISTER unless redis.get(student_number)
    delete_from_redis

    respond_with :message, text: DELETE
  end

  private

  def delete_from_redis
    redis.del(student_number)
    redis.del(payload['from']['id'])
  end
end
