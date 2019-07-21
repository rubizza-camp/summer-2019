require 'telegram/bot'
require 'httparty'
require 'open-uri'
require 'redis'
require 'redis-activesupport'
require 'redis-rails'
require 'redis-namespace'
require 'redis-rack-cache'


redis = Redis.new(host: "localhost")
file_id = 'AgADAgADuqwxG-XUmEn_C8NMsB4Nyvfetw8ABDXpUpKaAAGHKkZPAQABAg'
response = HTTParty.get('https://api.telegram.org/bot919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg/getFile?file_id=AgADAgADuqwxG-XUmEn_C8NMsB4Nyvfetw8ABDXpUpKaAAGHKkZPAQABAg')
puts response['result']['file_path']
photo_url  = 'https://api.telegram.org/file/bot919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg/photos/file_0.jpg'
open('image.jpg', 'wb') do |file|
  file << open(photo_url).read
end
#redis.set("a", 1)
puts redis.get('a')

$redis = Redis::Namespace.new("site_point", :redis => Redis.new)
$redis.set("test_key", "Hello World!")
puts $redis.get('test_key')
Telegram::Bot::UpdatesController.session_store = :redis_store, {expires_in: 90.minutes}

