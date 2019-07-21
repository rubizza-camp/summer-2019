class RedisStorageController
  def self.user_name_is_free?(user_name)
    redis = Redis.new
    redis_data = redis.get('registred_users')
    if redis_data
      current_used_names = JSON.parse(redis_data)
      !current_used_names.include?(user_name.to_s)
    else
      true
    end
  end

  def self.occupy_user_name(user_name)
    redis = Redis.new
    redis_data = redis.get('registred_users')
    if redis_data
      redis_update_registred_users(redis, redis_data, user_name)
    else
      redis_create_registred_users(redis, user_name)
    end
  end

  def self.redis_update_registred_users(redis, redis_data, user_name)
    current_used_names = JSON.parse(redis_data)
    current_used_names = [] if current_used_names
    current_used_names << user_name.to_s
    redis.set('registred_users', current_used_names.to_json)
  end

  def self.redis_create_registred_users(redis, user_name)
    current_used_names = []
    current_used_names << user_name.to_s
    redis.set('registred_users', current_used_names.to_json)
  end
end
