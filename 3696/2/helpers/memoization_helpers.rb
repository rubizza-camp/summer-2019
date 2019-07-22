# frozen_string_literal: true

require 'redis'
require 'yaml'

module MemoizationHelpers
  DATA_PATH = './data/numbers.yaml'
  NUMBERS_LIST_KEY = 'numbers'

  def redis
    @redis ||= Redis.new
  end

  def numbers
    @numbers ||= YAML.load_file(DATA_PATH).fetch(NUMBERS_LIST_KEY, []).map(&:to_i)
  end
end
