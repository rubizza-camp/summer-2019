# User.destroy_all

users = [
  { login: 'Jon', email: 'e1@example.com' },
  { login: 'Jane', email: 'e2@example.com' },
  { login: 'Jimm', email: 'e@example.com' },
  { email: 'e@example.com' }
]

users.each do |u|
  User.create(u)
end

# Restaurant.destroy_all

restaurants = [
  { name: 'Buloshnaya', location: 'somewhere over the rainbow', description: 'Best donuts ever', photo: 'images/Buloshnaya.jpg' },
  { name: 'AntiBuloshnaya', location: 'in HELL', description: 'Burn in HELL', photo: 'images/AntiBuloshnaya.jpg' }
]

restaurants.each do |r|
  Restaurant.create(r)
end

reviews = [
  { description: 'Best donuts ever', user_id: 17, restaurant_id: 15 },
  { description: 'Burn in HELL', user_id: 18, restaurant_id: 16 }
]

reviews.each do |r|
  Review.create(r)
end
