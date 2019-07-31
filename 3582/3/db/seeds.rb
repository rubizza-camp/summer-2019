# rubocop:disable all
require './app/models/restaraunt'
require './app/models/user'
require './app/models/comment'
Restaraunt.create(name: 'Plan B', location: 'Bogdana Hmelnickogo, 10a', description: 'Lorem ipsum')
Restaraunt.create(name: 'Svobodi 4', location: 'Svobodi, 4', description: 'Bla Bla')
Restaraunt.create(name: 'Natvris HE', location: 'Svyazistov, 4', description: 'Gruzinskii Restoran')
Restaraunt.create(name: 'Kamyaniza', location: 'Pervomayskaya, 18', description: 'Belarusian')
Restaraunt.create(name: 'Grand Cafe', location: 'Lenina, 2', description: 'French Kitchen')
User.create(name: 'Anon', email: 'super.user@gmail.com', password: '$2a$12$TL2P5gbV9oZ.9RFvJOnzuOhOFSrxRHsCEDNdFAMqjEab2FevVO.U.')
Comment.create(content: "Ochen' plohaya eda", rating: 1, user_id: 1, restaraunt_id: 1)
