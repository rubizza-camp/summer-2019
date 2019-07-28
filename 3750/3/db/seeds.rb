users = [
  { login: 'test', password: '123', email: 'admin@gmail.com' },
  { login: 'Chell', password: 'hf3', email: 'e@example.com' }
]

users.each do |u|
  User.create(u)
end

restaurants = [
  {
    name: 'Testtaurant', latitude: 53.858930, longitude: 27.482475,
    description: 'Best place to test you taste'
  },
  {
      name: 'Tempaurant', latitude: 54.858930, longitude: 26.482475,
      description: 'Best place to make some templates'
  }
]

restaurants.each do |restaurant|
  Restaurant.create(restaurant)
end