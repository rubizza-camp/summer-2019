locations = [
  { name: 'Good place', description: 'Good place for good people which is very nice.' },
  { name: 'Middle class place', description: 'Not so good as the first one, but still OK' },
  { name: 'Bad place', description: 'Name speaks books here. No good reviews expected' }
]

locations.each do |location|
  Location.create(location)
end
