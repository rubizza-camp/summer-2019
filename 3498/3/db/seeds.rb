places = [
  { name: 'Bistro de Luxe',
    address: 'Haradski Val 10',
    location: '53.900780, 27.551320',
    description: 'French cuisine',
    rating: 4 },
  { name: 'Tapas Bar',
    address: 'Internationalnaya 9',
    location: '53.901855, 27.554217',
    description: 'Spanish cuisine',
    rating: 4.5 }
]

places.each do |p|
  Place.create(p)
end
