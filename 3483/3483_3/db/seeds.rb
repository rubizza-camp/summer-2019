shop = [
  ['KFC', 'Ресторан с вкусной курочкой', 'просп. Победителей, 9, ТРЦ Galleria Minsk, этаж 6'],
  ['Мираж', 'Богатый выбор шаурмы на любой вкус', 'ул. Веры Хоружей, 2Б']
]

shop.each do |name, description, adress|
  Shop.create(name: name, description: description, adress: adress)
end
