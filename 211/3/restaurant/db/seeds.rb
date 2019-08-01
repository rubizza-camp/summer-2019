require 'faker'

Restaurant.destroy_all
restaurants = [
  { name: 'Buloshnaya',
    location: '59.9, 30.3',
    description: Faker::Books::Lovecraft.paragraph,
    photo: 'images/Buloshnaya.jpg' },
  { name: 'AntiBuloshnaya',
    location: '60, 20',
    description: Faker::Books::Lovecraft.paragraph,
    photo: 'images/AntiBuloshnaya.jpg' }
]

restaurants.each do |r|
  Restaurant.create(r)
end
