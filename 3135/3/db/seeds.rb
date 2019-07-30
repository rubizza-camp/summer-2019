# db/seeds.rb
#rubocop:disable all
restaurants = [
  { name: 'The Cheesecake Factory', location: '605 N Harbor Dr, Redondo Beach, CA 90277, USA', description: 'The Cheesecake Factory story begins in Detroit, Michigan in the 1940’s. Evelyn Overton found a recipe in the local newspaper that would inspire her “Original” Cheesecake. Everyone loved her recipe so much that she decided to open a small Cheesecake shop, but she eventually gave up her dream of owning her own business in order to raise her two small children, David and Renee. She moved her baking equipment to a kitchen in her basement and continued to supply cakes to several of the best restaurants in town while raising her family.' },
  { name: 'Din Tai Fung', location: 'Del Amo Fashion Center, 21540 Hawthorne Blvd #519, Torrance, CA 90503, USA', description: 'Originally founded as a cooking oil retail business in 1958, Din Tai Fung was reborn as a steamed dumpling and noodle restaurant in 1972. Today, Din Tai Fung has branches in Japan, the United States, South Korea, Singapore, China, Hong Kong, Indonesia, Malaysia, Australia, and Thailand. Din Tai Fung gives people throughout the world the opportunity to experience a classic taste of Taiwan.' },
  { name: 'The Reef Restaurant', location: '880 S Harbor Scenic Dr, Long Beach, CA 90802, USA', description: 'Founded in 1958 by themed-restaurant pioneer David Tallichet, The Reef offers a unique tropical hideaway from Long Beach’s bustling city life. With its highly coveted location and unparalleled views of the Pacific coast, The Reef has been a favorite destination for locals and visitors for delicious meals, refreshing cocktails, relaxing vibes and upscale service.' },
  { name: 'Il Fornaio', location: 'F, 1800 Rosecrans Ave, Manhattan Beach, CA 90266, USA', description: 'The Il Fornaio brand was established in 1972 as a baking school in Barlassina, Lombardia, Italy. It opened a retail bakery in Milan in 1975, and was licensed in 1981 to Williams-Sonoma as a retail bakery concept. Williams-Sonoma opened four locations in California before selling the business to private investors in 1983.' },
  { name: 'Good Stuff Restaurant', location: '1286 The Strand, Hermosa Beach, CA 90254, USA', description: 'Founded in 1979, Good Stuff Restaurants have grown to become a staple in the South Bay community. From eggs benedict to delicious fajitas, Good Stuff’s wide range of healthy meal options keep customers coming back for more.' },
]

users = [
  { username: 'testuser1', email: 'tu1@mb.com', password_digest: 'somehash' },
  { username: 'testuser2', email: 'tu2@mb.com', password_digest: 'somehash' },
  { username: 'testuser3', email: 'tu3@mb.com', password_digest: 'somehash' }
]

reviews = [
  { user_id: 1, restaurant_id: 1, rating: 5, description: "Nice burgers, crispy fries, fuzzy soda!" },
  { user_id: 1, restaurant_id: 2, rating: 4, description: "Alright burgers, a bit cold fries, a small soda!" },
  { user_id: 1, restaurant_id: 3, rating: 3, description: "Decent burgers, moist fries, not that sweet soda!" },
  { user_id: 1, restaurant_id: 4, rating: 2, description: "Disaster burgers, garbage fries, no soda!" },
  { user_id: 2, restaurant_id: 1, rating: 4, description: "Solid entree, ok main dish, sweet dessert!" },
  { user_id: 2, restaurant_id: 2, rating: 3, description: "Regular entree, disproportional main dish, tasteless dessert!" },
  { user_id: 2, restaurant_id: 3, rating: 2, description: "Terrible entree, heart breaking main dish, minuscule dessert!" },
  { user_id: 2, restaurant_id: 4, rating: 1, description: "Joke entree, burnt main dish, nogo dessert!" },
]

restaurants.each do |r|
  Restaurant.create(r)
end

users.each do |u|
  User.create(u)
end

reviews.each do |r|
  Review.create(r)
end
#rubocop:enable all
