require 'csv'

NAME = 0
LOCATION = 1
DESCRIPTION = 2
RATING = 3

CSV.foreach(File.realpath('db/data/places.csv')) do |row|
  Place.create(
    place_name: row[NAME],
    location: row[LOCATION],
    description: row[DESCRIPTION],
    place_rating: row[RATING]
  )
end
