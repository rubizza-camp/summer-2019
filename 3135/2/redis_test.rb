require 'redis'

redis = Redis.new(host: 'localhost')

redis.set('a', 1)

b = redis.get('a')
puts b.class
puts b