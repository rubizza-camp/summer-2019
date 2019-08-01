# rubocop:disable all
require './app/models/restaurant'
require './app/models/user'
require './app/models/comment'
Restaurant.create(name: 'Plan B', location: 'Bogdana Hmelnickogo, 10a', description: 'Best of the Best')
Restaurant.create(name: 'Svobodi 4', location: 'Svobodi, 4', description: 'Bla Bla')
Restaurant.create(name: 'Kamyaniza', location: 'Pervomayskaya, 18', description: 'Belarusian')
Restaurant.create(name: 'Natvris HE', location: 'Svyazistov, 4', description: 'Gruzinskii Restoran')
Restaurant.create(name: 'Grand Cafe', location: 'Lenina, 2', description: 'French Kitchen')
Restaurant.create(name: 'Kuhmistr', location: 'Karla Marksa, 40', description: 'Belarusian Kitchen')
User.create(name: 'Anon', email: 'super.user@gmail.com', password: '$2a$12$TL2P5gbV9oZ.9RFvJOnzuOhOFSrxRHsCEDNdFAMqjEab2FevVO.U.')
Comment.create(content: "Ochen' plohaya eda", rating: 1, user_id: 1, restaurant_id: 1)
