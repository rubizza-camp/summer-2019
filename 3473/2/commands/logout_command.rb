# frozen_string_literal: true

require_relative './util'

module LogoutCommand
  include Util

  def logout!(*)
    if registered?
      out
      respond_with :message, text: 'You are excluded'
    else
      respond_with :message, text: 'You are not registered'
    end
  end

  def out
    redis.del(session[:number])
    redis.set("#{session[:number]} state", session[:state])
    session.delete(:number)
  end
end
