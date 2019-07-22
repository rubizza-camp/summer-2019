require 'yaml'
require 'redis'
require 'redis-activesupport'
require 'redis-rails'
require 'redis-namespace'
require 'redis-rack-cache'

class DataStorageRedis
  attr_reader :data_base

  def initialize
    @data_base = Redis::Namespace.new("telegram-bot-app", :redis => Redis.new)
    @data_base_id = Redis::Namespace.new("telegram-bot-app-id", :redis => Redis.new)
  end

  def update_data_base(file_path)
    file = YAML.safe_load(File.read(file_path)) #Data/camp_participants.yaml
    file['participents'].each do |participant|
      @data_base.set(participant.keys.first.to_s, participant['telegram_id'].to_s)
      @data_base_id.set(participant['telegram_id'].to_s, participant.keys.first.to_s)
    end
  end

  def find_number_by_id(id)
    @data_base_id.get(id)
  end

  def find_id_by_personal_number(number)
    @data_base.get(number)
  end
end

# redis = DataStorageRedis.new
# puts redis.find_number_by_id('222443')
# puts redis.find_id_by_personal_number('3529')
