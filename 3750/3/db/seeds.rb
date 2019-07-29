restaurants = [
  {
    name: 'Testtaurant', latitude: 53.858930, longitude: 27.482475,
    short_description: 'Best place to test you taste',
    description: 'You will never ever find
better place to test anything you want. A lot of customers admits
perfect naming in this place, most of them especially like names like test, test2 and testing_test.'
  },
  {
    name: 'Tempaurant', latitude: 54.858930, longitude: 26.482475,
    short_description: 'Best place to make some templates',
    description: 'Did you know that Tempaurant itself is a huge template for restaurants.
On such gorgeous template based the best restaurant for tests - Testtaurant!
So if you feel kinda lazy at the beginning of some new project your choice is
Tempaurant - best template with best templates in it.'
  }
]

restaurants.each do |restaurant|
  Restaurant.create(restaurant)
end
