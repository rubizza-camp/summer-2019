# frozen_string_literal: true

# :nodoc:
module Identifiers
  def registred?
    session.key?(:number)
  end

  def user_id
    payload['from']['id']
  end
end
