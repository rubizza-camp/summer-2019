require './app/models/restaraunt'
require './app/models/user'
Restaraunt.create(name: 'Plan B', location: 'Bogdana Hmelnickogo, 10a', description: 'Lorem ipsum')
Restaraunt.create(name: 'Svobodi 4', location: 'Svobodi, 4', description: 'Bla Bla')
Restaraunt.create(name: 'Natvris HE', location: 'Svyazistov, 4', description: 'Gruzinskii Restoran')
Restaraunt.create(name: 'Kamyaniza', location: 'Pervomayskaya, 18', description: 'Belarusian')
Restaraunt.create(name: 'Grand Cafe', location: 'Lenina, 2', description: 'French Kitchen')
User.create(name: 'SuperUser', password_digest: '1233456')
