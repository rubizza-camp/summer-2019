shop = [
  ['Лидо', 'Ресторан быстрого обслуживания', 'пр. Независимости, д.49, пом.1'],
  ['Dodo pizza', 'Популярная сеть пиццерий в городе по знаменитой российской франшизе.
    Додо пицца входит в топ пиццерий Минска.', 'проспект Дзержинского 126']
]

shop.each do |name, description, adress|
  Shop.create(name: name, description: description, adress: adress)
end