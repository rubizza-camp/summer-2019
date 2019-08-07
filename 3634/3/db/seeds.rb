Restaurant.create(name: 'Vasilki',
                  latitude: 53.923152,
                  longitude: 27.607001,
                  description: "Every day Restaurants of National Cuisine ‘Vasilki’ meet their
    Guests with Belarusian warm hospitality. It is not only a place of tasty food,
    but also the place where you could relax your mind and spend time in the company
    of your dearest people!")
Restaurant.create(name: 'Falcone',
                  latitude: 53.902018,
                  longitude: 27.542650,
                  description: "Welcome to the Falcone restaurant! You’ll have an unforgettable
    evening time here, enjoying delicious dishes of Italian cuisine accompanied with
    live music. We invite you to learn more about the history of the restaurant.")
Restaurant.create(name: 'Bistro de Luxe',
                  latitude: 53.900804,
                  longitude: 27.551246,
                  description: "We are committed to elegance in that no matter what, and offer
    classical cuisine 'Bistro'. White crisp tablecloths, attentive service, well-dressed
    audience, a fresh world press - all this awaits you in the Bistro de Luxe. Every day
    we are open for breakfast, lunch and dinner.")
User.create(name: 'Aleks',
            email: 'mikitsik@gmail.com',
            password: '111111')
User.create(name: 'Bob',
            email: 'example@gmail.com',
            password: '111111')
Comment.create(mark: 5,
               body: 'Yay! It is cool restaurant. Recommend it!',
               user_id: 1,
               restaurant_id: 1)
Comment.create(mark: 4,
               body: 'Delicios! But staff are not much affable.',
               user_id: 2,
               restaurant_id: 1)
Comment.create(mark: 3,
               body: 'This place is not what I wating for!',
               user_id: 1,
               restaurant_id: 2)
Comment.create(mark: 2,
               body: 'Harmful!',
               user_id: 2,
               restaurant_id: 2)
