# frozen_string_literal: true

require 'redis'
require 'yaml'
module Util
  def registered?
    session.key?(:number)
  end

  def id
    subject = from || chat
    subject['id'] if subject
  end

  def redis
    @redis ||= Redis.new
  end

  def token
    @token ||= YAML.load_file('./data/config.yml')['token'].first
  end
end
