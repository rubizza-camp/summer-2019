module DeleteCommand
  def delete!(*)
    response_message = t(:need_to_register)
    if student_registered?(student_number)
      redis.del(student_number)
      redis.del(payload['from']['id'])
      response_message = t(:delete_end)
    end
    respond_with :message, text: response_message
  end
end
