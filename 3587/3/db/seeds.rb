shops = [
  ['Лидо', 'Ресторан быстрого обслуживания', 'пр. Независимости, д.49, пом.1'],
  ['Dodo pizza', 'Популярная сеть пиццерий в городе по знаменитой российской франшизе.
    Додо пицца входит в топ пиццерий Минска.', 'проспект Дзержинского 126']
]

shops.each do |name, description, address|
  Shop.create(name: name, description: description, address: address)
end
