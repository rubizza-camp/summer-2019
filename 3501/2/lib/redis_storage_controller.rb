class RedisStorageController
  class << self
    attr_reader :redis

    def initialize_redis
      @redis = Redis.new
    end

    def user_name_is_free?(user_name)
      redis_data = redis.get('registred_users')
      if redis_data
        used_names = JSON.parse(redis_data)
        !used_names.include?(user_name.to_s)
      else
        true
      end
    end

    def occupy_user_name(user_name)
      redis_data = redis.get('registred_users')
      if redis_data
        redis_update_registred_users(redis_data, user_name)
      else
        redis_create_registred_users(user_name)
      end
    end

    def redis_update_registred_users(redis_data, user_name)
      used_names = JSON.parse(redis_data)
      used_names = [] if used_names
      used_names << user_name.to_s
      redis.set('registred_users', used_names.to_json)
    end

    def redis_create_registred_users(user_name)
      used_names = []
      used_names << user_name.to_s
      redis.set('registred_users', used_names.to_json)
    end
  end
end
