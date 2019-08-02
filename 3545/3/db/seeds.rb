locations = [
  { name: 'Good place', description: 'Good place for good people, it is very nice.' },
  { name: 'Middle class place', description: 'Not so good as the first one, but still OK' },
  { name: 'Bad place', description: 'Name speaks books here. No good reviews expected' }
]

locations.each do |location|
  Location.create(location)
end

users = [
  { username: 'Loyal_user', email: 'loyal@nice.com', password: 'secure' },
  { username: 'Normal_user', email: 'normal@ok.com', password: 'secure' },
  { username: 'Angry_user', email: 'angryl@hate.com', password: 'secure' }
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
