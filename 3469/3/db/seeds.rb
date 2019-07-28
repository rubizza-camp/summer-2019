description_mac = File.open('./restaurant_descriptions/mac.txt', 'r').read
description_hapines = File.open('./restaurant_descriptions/hapines.txt', 'r').read
mac_s = File.open('restaurant_descriptions/mac_s.txt', 'r').read
hapines_s = File.open('restaurant_descriptions/hapines_s.txt', 'r').read

restaurants = [
    {name: 'MacDonalds', address: '812 Broadway, New York, NY 10003, USA', short_description: mac_s, full_description: description_mac },
    {name: 'Hapines', address: '2049 Broadway, New York, NY 10023, USA',short_description: hapines_s, full_description: description_hapines },
]

restaurants.each do |place|
  Restaurant.create(place)
end
# {name: 'Gruzin_by', latitude: '303 S Broadway Ste 200, Denver, CO 80209, USA', short_description: descr, full_description: descr },