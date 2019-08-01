# frozen_string_literal: true

users = [
  { username: 'ex@ex.ex', password: 'ex', email: 'ex@ex.ex' }
]

users.each do |u|
  User.create(u)
end

cafes = [{ name: 'Stepantsminda', lat: 42.652220, lon: 44.645830,
           short_info: ' is a townlet in Georgia',
           description: 'Town is located along the banks of the Terek River'\
', 157 kilometers (98 mi) to the north of Tbilisi at an elevation of 1,740'\
' meters (5,710 feet) above sea level.'\
' Stepantsminda’s climate is moderately humid with relatively dry,'\
' cold winters and long and cool summers. '\
'The average annual temperature is 4.9 degrees Celsius.' },
         { name: 'Flåmselvi', lat: 60.793889, lon: 7.104167,
           short_info: 'long river in Norway',
           description: 'The river begins as runoff from the Omnsbreen glacier'\
     ' about 5 kilometres (3.1 mi)'\
     '  northwest of Finse in the municipality of Ulvik in Hordaland county. '\
     ' The river is known as the Moldåni river in this area. It then flows'\
     ' through a series of lakes heading'\
     ' to the northwest where it crosses into Aurland municipality in Sogn'\
      ' og Fjordane county. ' },
         { name: 'Kyoto', lat: 35.011667, lon: 135.768333,
           short_info: 'town in Japan',
           description: ' is the capital of Kyoto Prefecture in Japan. Located'\
      ' in the Kansai region on the island of Honshu,'\
     ' Kyoto forms a part of the Keihanshin metropolitan area along with Osaka'\
     ' and Kobe. '\
     ' As of 2018, the city has a population of 1.47 million.' }]

cafes.each do |cafe|
  Place.create(cafe)
end
