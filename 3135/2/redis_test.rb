require 'redis'

redis = Redis.new(host: 'localhost')

redis.set('a', 1)
redis.del('d')

puts redis.exists('a')
puts redis.exists('b')