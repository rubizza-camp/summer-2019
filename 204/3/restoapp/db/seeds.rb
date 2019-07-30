# rubocop: disable Metrics/LineLength

restraunts = [
  { title: 'Брассерия Крик', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7994.764900692217!2d30.31239705824029!3d59.93726567233754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x6863f7664ffc3b95!2sKriek!5e0!3m2!1sru!2sru!4v1564386435807!5m2!1sru!2sru', description: 'Brasserie Kriek - первая сеть бельгийских ресторанов в Спб с изысканными блюдами авторской кухни и коллекцией пива в 150 сортов.' },
  { title: 'Gras Madbaren', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1998.6944187973277!2d30.334484815892232!3d59.937212681875664!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46963109750342b5%3A0xa101368ca37be1ed!2sGras+x+Madbaren!5e0!3m2!1sru!2sru!4v1564344265563!5m2!1sru!2sru', description: 'Современная кухня в северном стиле, основанная на сезонных российских продуктах' },
  { title: 'Арка', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1998.6912065231961!2d30.318989951462786!3d59.937265981786695!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4696310f90d52de5%3A0x6fedfedf448ed3a2!2z0JBya2E!5e0!3m2!1sru!2sru!4v1564386341742!5m2!1sru!2sru', description: 'ARKA bar, food & space - стильный бар с самыми длинными контактными барными стойками, авторскими коктейлями, современной гастрономией и лучшими в городе вечеринками.' },
  { title: 'Оба Два', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1998.5947167962959!2d30.360680951462864!3d59.938866981787264!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x469631989c6c2bb5%3A0x86cdb4bd0d403179!2z0J7QsdCw0JTQstCw!5e0!3m2!1sru!2sru!4v1564386473129!5m2!1sru!2sru', description: 'Гастробар в центре Санкт-Петербурга основанный двумя шеф-поварами Андреем Друковским и Леонидом Шемякиным. Smart Comfort Food.' },
  { title:  'ТарТарБар', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1998.5304276154623!2d30.364134151462878!3d59.93993368178767!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46963198f7c3ea5f%3A0xcbd55e1a21958ee8!2z0KLQsNGA0YLQsNGA0LHQsNGA!5e0!3m2!1sru!2sru!4v1564386311647!5m2!1sru!2sr', description: 'Гастробар в Виленском переулке от знаменитой команды Duo. Фишкой «Тартарбара» стали блюда из сырых мяса и рыбы.' },
  { title:  'HITCH', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d127994.8638916662!2d30.178260909414366!3d59.91687921138883!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xed75fb500f86b95c!2zSElUQ0gg0KDQtdGB0YLQvtGA0LDQvQ!5e0!3m2!1sru!2sru!4v1564386519112!5m2!1sru!2sru', description: 'Двухэтажный мясной ресторан на Петроградской стороне с большим выбором разливного пива и собственной пекарней.' },
  { title:  'HUNT', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31967.072557162373!2d30.346918500986494!3d59.949695888463935!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x3def375e2fecdc84!2sHUNT!5e0!3m2!1sru!2sru!4v1564386546049!5m2!1sru!2sru', description: 'Тройной удар по улице Рубинштейна от команды Buddha Bar. В первом зале организован raw bar для любителей морепродуктов. Вторая часть посвящена дровяной печи и всевозможным лепешкам, кашам, пирогам с живого огня. Дальше — мясной ресторан. За меню отвечает бренд-шеф Евгений Белозеров, его главным принципом является comfort-food: неклассическая, но и не заумная еда из локальных продуктов.' },
  { title:  'Bao Mochi', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1998.7617858717053!2d30.347162851462727!3d59.936094881786325!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x469631a12941e129%3A0x2edcac96a9f61bc3!2sBao+Mochi!5e0!3m2!1sru!2sru!4v1564386567240!5m2!1sru!2sru', description: 'Современный интерьер, дружественная атмосфера и качественный европейский сервис сопровождают блюда азиатской кухни, выполненные по исконным технологиям, с использованием аутентичных продуктов и старинных рецептов.' },
  { title:  'Sub-zero', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1999.3031778188051!2d30.340747051462326!3d59.92711128178301!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x469631aed6a1f4c5%3A0x4b3ed7ad2c50f92a!2sSubzero!5e0!3m2!1sru!2sru!4v1564386589441!5m2!1sru!2sru', description: 'Рестобар с современной японской кухней на Рубинштейна. Заведение оформлено в индустриальном стиле: лаконичная мебель из светлого дерева, декоративные детали из темного металла и серые бетонные стены.' },
  { title:  'Квартира Кости Кройца', google_map_link: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1999.053526279831!2d30.352686951462506!3d59.93125398178454!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x469631a4564b87cd%3A0x1dad7faf287118e4!2z0JrQstCw0YDRgtC40YDQsCDQmtC-0YHRgtC4INCa0YDQvtC50YbQsA!5e0!3m2!1sru!2sru!4v1564386616637!5m2!1sru!2sru', description: 'Квартира Кости Кройца — это ресторан и чайная комната, между которыми расположился бар, а так же апартаменты, в которых можно остановиться. Всё это находится в городской квартире-мансарде на Невском проспекте, откуда открывается приятный вид на крыши и небо Петербурга.' }
]

# rubocop: enable Metrics/LineLength

accounts = [
  { name: 'Admin1', password: 'qwe', email: 'artursmolin@gmail.com' },
  { name: 'Admin2', password: 'asd', email: 'asd@mail.ru' },
  { name: 'Admin3', password: 'zxc', email: 'zxc@mail.ru' }
]

restraunts.each do |restraunt|
  Restraunt.create(restraunt)
end

accounts.each do |account|
  Account.create(account)
end
