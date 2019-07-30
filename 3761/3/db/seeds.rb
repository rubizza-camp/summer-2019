places = [
  { name: 'Zerno-cafe', location: 'Minsk, Avenue of Independence, 44',
    main_description: 'Cafe - Cozy place - Vegan food - Relaxed atmosphere',
    full_description: 'We will be glad to see you on a visit, but if you do not
     have such an opportunity, take advantage of the delivery of grain to your
     home or office!',
    path_to_image:
     'https://media-cdn.tripadvisor.com/media/photo-s/13/4a/a5/1f/zerno-cafe.jpg' },
  { name: 'Lido', location: 'Minsk Kulman str., 5A',
    main_description: 'Fast food restaurant',
    full_description: 'Restaurant "LIDO" is a place where all guests are greeted
     with a warm smile and treated to home-style delicious dishes.
     Having visited our restaurant once, you will want to come back here again.',
    path_to_image: 'http://www.lido.by/test/wp-content/uploads/2018/06/010-1024x682.jpg' }
]

places.each do |place|
  Place.create(place)
end
