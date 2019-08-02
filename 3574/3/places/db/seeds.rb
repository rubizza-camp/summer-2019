restaurants = [
  { name: 'Ресторан «Bella Rosa (Белла роcа)»',
    description: 'Кухня: Итальянская, Средиземноморская, Европейская, Авторская.',
    coordinate: 'Гикало ул. 3, Минск' },
  { name: 'Ресторан «Ля Менска»',
    description: 'Кухня: Белорусская, Европейская, Авторская.',
    coordinate: 'Ермака пер. 21, Минск' },
  { name: 'Ресторан «Эриван»',
    description: 'Кухня: Белорусская, Армянская, Русская, Европейская, Авторская.',
    coordinate: '1-й Загородный пер. 3' }
]

restaurants.each do |restor|
  Restaurant.create(restor)
end
