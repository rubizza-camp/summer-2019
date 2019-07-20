require 'httparty'
require 'open-uri'

file_id = 'AgADAgADuqwxG-XUmEn_C8NMsB4Nyvfetw8ABDXpUpKaAAGHKkZPAQABAg'
response = HTTParty.get('https://api.telegram.org/bot919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg/getFile?file_id=AgADAgADuqwxG-XUmEn_C8NMsB4Nyvfetw8ABDXpUpKaAAGHKkZPAQABAg')
puts response['result']['file_path']
photo_url  = 'https://api.telegram.org/file/bot919190207:AAFfJhW2frNEWYeaSAvxhgwC6I233JVnVBg/photos/file_0.jpg'
open('image.jpg', 'wb') do |file|
  file << open(photo_url).read
end
