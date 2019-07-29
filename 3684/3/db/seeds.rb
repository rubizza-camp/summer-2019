kfc_descr = File.open('restaurant_descriptions/kfc_short_description.txt', 'r').read
mac_descr = File.open('restaurant_descriptions/mac_short_description.txt', 'r').read
bk_descr = File.open('restaurant_descriptions/burger_king_short_description.txt', 'r').read
bk_full_descr = File.open('restaurant_descriptions/burger_king_full_description.txt', 'r').read
kfc_full_descr = File.open('restaurant_descriptions/kfc_full_description.txt', 'r').read
mac_full_descr = File.open('restaurant_descriptions/mac_full_description.txt', 'r').read

restaurants = [
  {
    name: 'KFC на Немиге',
    location: 'ул. Немига 2',
    short_description: kfc_descr,
    full_description: kfc_full_descr,
    score: 0
  },
  {
    name: 'MacDonalds',
    location: 'пр-кт Независимости 23',
    short_description: mac_descr,
    full_description: mac_full_descr,
    score: 0
  },
  {
    name: 'Burger King',
    location: 'пр-кт победителей 9',
    short_description: bk_descr,
    full_description: bk_full_descr,
    score: 0
  }
]

restaurants.each do |r|
  Restaurant.create(r)
end
