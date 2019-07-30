place = [
  {
    name: 'KFC',
    location: 'ул. Романовская Слобода 13',
    score: 0
  },
  {
    name: 'MacDonalds',
    location: 'ул. Максима Танка 2',
    score: 0
  },
  {
    name: 'Burger King',
    location: 'пр-кт победителей 9',
    score: 0
  }
]

place.each do |p|
  Place.create(p)
end
