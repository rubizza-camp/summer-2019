# frozen_string_literal: true

module Util
  def registered?
    session.key?(:number)
  end

  def id
    @id ||= (from || chat).to_h['id']
  end

  def redis
    @redis ||= self.class.redis
  end

  def token
    @token ||= self.class.token
  end
end
