require 'csv'

NAME = 0
LOCATION = 1
DESCRIPTION = 2
RATING = 3

CSV.foreach(File.realpath('db/data/places.csv')) do |row|
  Place.find_or_create_by(place_name: row[NAME]).update(location: row[LOCATION],
                                                        description: row[DESCRIPTION],
                                                        place_rating: row[RATING])
end
