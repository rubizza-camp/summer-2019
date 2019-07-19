require 'redis'

#redis = Redis.new(host: 'localhost')

redis.set('a', 1)

a = redis.get('a')
b = redis.get('b')

puts a
puts b.inspect