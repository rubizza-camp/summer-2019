# frozen_string_literal: true

# class for store user's data
class User
  INITIAL_STATE = :wait_start

  attr_reader :chat_id

  def initialize(chat_id)
    @chat_id = chat_id
  end

  def state
    @state ||= Redis.current.get(chat_id) || INITIAL_STATE
  end

  def state=(new_state)
    Redis.current.set(chat_id, new_state)
    @state = new_state
  end

  def student_id
    @student_id ||= Redis.current.get("chat:#{chat_id}:student")
  end

  def student_id=(new_student_id)
    Redis.current.set("chat:#{chat_id}:student", new_student_id)
    @student_id = new_student_id
  end

  def timestamp
    @timestamp ||= Redis.current.get("chat:#{data[:chat_id]}:timestamp")
  end

  def set_timestamp
    t = Time.now
    Redis.current.set("chat:#{data[:chat_id]}:timestamp", t)

    @timestamp = t
  end
end
