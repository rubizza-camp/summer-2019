module DeleteCommand
  def delete!(*)
    response = response_unregester
    if student_registered?(student_number)
      redis.del(student_number)
      redis.del(payload['from']['id'])
      response = response_delete_end
    end
    respond_with :message, text: response
  end
end
