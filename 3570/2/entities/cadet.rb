# frozen_string_literal: true

Cadet = Struct.new(:id, :telegram_id, :error) do
  REDIS_CADET_PREFIX = 'cadet_'

  def self.find(number)
    telegram_id = Redis.new.get(redis_cadet_key(number))
    new(number, telegram_id) if telegram_id
  end

  def save
    Redis.new.set(self.class.redis_cadet_key(id), telegram_id.to_i)
  end

  def self.redis_cadet_key(number)
    "#{REDIS_CADET_PREFIX}_#{number}"
  end

  def valid?
    !error
  end
end
