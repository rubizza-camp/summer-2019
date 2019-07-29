Restaurant.destroy_all

# rubocop:disable Metrics/LineLength
restaurants = [
  { name: 'Buloshnaya',
    location: '59.9, 30.3',
    description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellat id, dignissimos ea accusantium accusamus ex omnis officia, non at aspernatur, impedit porro. Dignissimos numquam ratione maiores quod totam commodi vero!
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates sed eveniet, qui, magni maiores earum voluptate fugit veritatis fuga repellendus minima, sit odit. Similique numquam veritatis, eaque voluptatem, rerum quaerat.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam quas minus ea odit, sequi explicabo quasi quos doloribus ipsum architecto hic reiciendis id voluptas! Ad, nulla, fuga. Tenetur, nostrum, similique?',
    photo: 'images/Buloshnaya.jpg' },
  { name: 'AntiBuloshnaya',
    location: '59.8, 30.2',
    description: 'Lorem ipsum dolor sit amet. Repellat id, dignissimos ea accusantium accusamus ex omnis officia, non at aspernatur, impedit porro. Dignissimos numquam ratione maiores quod totam commodi vero!
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates sed eveniet, qui, magni maiores earum voluptate fugit veritatis fuga repellendus minima, sit odit. Similique numquam veritatis, eaque voluptatem, rerum quaerat.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam quas minus ea odit, sequi explicabo quasi quos doloribus ipsum architecto hic reiciendis id voluptas! Ad, nulla, fuga. Tenetur, nostrum, similique?',
    photo: 'images/AntiBuloshnaya.jpg' }
]
# rubocop:enable Metrics/LineLength
restaurants.each do |r|
  Restaurant.create(r)
end
