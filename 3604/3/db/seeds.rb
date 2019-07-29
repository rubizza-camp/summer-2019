places = [
  {
    name: 'Lido',
    location: 'ul.Kulman, 5A',
    main_description: 'The restaurant operates on the principle of self-service and an open kitchen,
    so you do not need to wait long for the waiter to accept the order and prepare your dish.',
    full_description: 'Every day in the restaurant menu a wide selection of freshly prepared dishes
    of Belarusian and European cuisine,
    as well as the constant updating of the menu, taking into account the seasons of the year.
    LIDO has a surprisingly pleasant interior, national colors and a warm homely atmosphere,
    and the design of the halls changes in accordance with the holidays and seasons.',
    path_to_image: 'http://www.lido.by/test/wp-content/uploads/2011/07/%D0%BB%D0%B8%D0%B4%D0%BE-%D0%BD%D0%B0-%D0%BA%D1%83%D0%BB%D1%8C%D0%BC%D0%B0%D0%BD-768x526.jpg'
  },

  {
    name: 'Lido',
    location: 'ul.Kulman, 5A',
    main_description: 'The restaurant operates on the principle of self-service and an open kitchen,
    so you do not need to wait long for the waiter to accept the order and prepare your dish.',
    full_description: 'Every day in the restaurant menu a wide selection of freshly prepared dishes
    of Belarusian and European cuisine,
    as well as the constant updating of the menu, taking into account the seasons of the year.
    LIDO has a surprisingly pleasant interior, national colors and a warm homely atmosphere,
    and the design of the halls changes in accordance with the holidays and seasons.',
    path_to_image: 'http://www.lido.by/test/wp-content/uploads/2011/07/%D0%BB%D0%B8%D0%B4%D0%BE-%D0%BD%D0%B0-%D0%BA%D1%83%D0%BB%D1%8C%D0%BC%D0%B0%D0%BD-768x526.jpg'
  }
]

places.each do |place|
  Place.create(place)
end
