# frozen_string_literal: true

require 'redis'
require 'yaml'

module StaticUtil
  def redis
    @redis ||= Redis.new
  end

  def token
    @token ||= YAML.load_file('./data/config.yml').to_h['token'].to_a.first
  end
end
