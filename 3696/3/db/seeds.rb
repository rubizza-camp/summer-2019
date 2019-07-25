cafes = [
  { name: 'Hesburger', latitude: 53.858930, longitude: 27.482475,
    short_description: 'Finnish fastfood',
    full_description: "Hesburger's delicious history dates back to 1966 when Heikki Salmela and"\
'his wife Kirsti founded Kievari Grilli in Naantali. In the 1970s, the hard-working '\
'entrepreneurs set their sights on Turku where the budding company enjoyed enormous '\
'popularity among the locals, particularly at a location known as Puutorin Grilli.' },
  { name: 'Enzo', latitude: 53.890113, longitude: 27.574469,
    short_description: 'Just fastfood',
    full_description: 'One of the best places in the city, which is worth visiting in Minsk'\
' not only for breakfast. The cafe is located on Kastryčnickaja Street – the most vibrant street'\
' of the city. So you can not only eat a decent breakfast or dinner here, but also find yourself'\
'  in the epicenter of the Minsk creative life and take photos of numerous murals.' }
]

cafes.each do |cafe|
  Place.create(cafe)
end
