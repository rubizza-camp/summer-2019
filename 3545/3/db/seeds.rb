require 'csv'

doc = CSV.read('./info.csv')

locations = [
  { name: 'Good place', description: doc[0][1], full_description: doc[1][1], photo_url: doc[8][1] },
  { name: 'OK place', description: doc[2][1], full_description: doc[3][1], photo_url: doc[7][1] },
  { name: 'Bad place', description: doc[4][1], full_description: doc[5][1], photo_url: doc[6][1] }
]

locations.each do |location|
  Location.create(location)
end

users = [
  { username: 'Loyal_user', email: 'loyal@nice.com', password: 'secure' },
  { username: 'Normal_user', email: 'normal@ok.com', password: 'secure' },
  { username: 'Angry_user', email: 'angry@hate.com', password: 'secure' }
]

users.each do |user|
  User.create(user)
end

commentaries = [
  { text: 'the best one!', user_id: 1, location_id: 1, points: 5 },
  { text: 'the OK one!', user_id: 2, location_id: 1, points: 3 },
  { text: 'the bad one!', user_id: 3, location_id: 1, points: 1 },
  { text: 'the best one!', user_id: 1, location_id: 2, points: 5 },
  { text: 'the OK one!', user_id: 2, location_id: 2, points: 3 },
  { text: 'the bad one!', user_id: 3, location_id: 2, points: 1 },
  { text: 'the best one!', user_id: 1, location_id: 3, points: 5 },
  { text: 'the OK one!', user_id: 2, location_id: 3, points: 3 },
  { text: 'the bad one!', user_id: 3, location_id: 3, points: 1 }
]

commentaries.each do |commentary|
  Commentary.create(commentary)
end
