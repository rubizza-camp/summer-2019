# rubocop: disable all
places = [
  {name: 'Lido', location: 'Minsk, Kulman street, 5A',
    short_description: 'Home cooking in national traditions',
    full_description: 'Restaurant "LIDO" is a place where all guests are
    greeted with a warm smile and treated to home-style delicious dishes.
    Having visited our restaurant once, you will want to come back here
    again. Every day the restaurant menu offers a wide selection of
    freshly prepared dishes of Belarusian and European cuisine, as well
    as a constant update of the menu, taking into account the seasons.
    "LIDO" has a surprisingly pleasant interior, national color and a
    warm home atmosphere, and the design of the halls changes in
    accordance with the holidays and seasons.',
    path_to_image:
    'https://s14.stc.all.kpcdn.net/share/i/12/10460722/inx960x640.jpg'},
  { name: 'Texas Chicken', location: 'Minsk, V. Horuzhei st., 8/5',
    short_description: 'Fast food cafe',
    full_description: 'For more than 60 years Texas Chicken is famous for
    the unique taste of chicken cooked according to a unique recipe.
    Home-made taste, high quality of all ingredients, varied menu, fast
    service – this is exactly what explains the popularity of Texas Chicken
    restaurants in the world!',
    path_to_image:
    'https://media-cdn.tripadvisor.com/media/photo-s/0f/c6/83/68/logo-sign.jpg'},
  { name: 'Plan B', location: 'Minsk, Bogdan Khmelnitsky street, 10A',
    short_description: 'Original, atmospheric and not pathetic institution of another format.',
    full_description: 'This cosy and individual interior in the loft style, dark tones and
    subdued light. Plan B bar is not a party place, but an atmospheric bar for a pleasant 
    and quality rest. Plan B can accommodate from 100 people and is divided into functional areas:
    Cafe, Main hall with bar, Lounge-room, the terrace is warm and heated.
    We comfortably accommodate any company: there are tables for two, four and six people, 
    surrounded by soft chairs or sofas, and a secluded Lounge-room for up to 15 people.
    Plan B is always happy to welcome you, as you can see by talking to the team: 
    bartenders and English-speaking bar staff.
    The bar Offers European, Belarusian and original cuisine, the development of which 
    was made every effort and a total charge of positive emotions.',
    path_to_image:
    'https://media-cdn.tripadvisor.com/media/photo-s/16/28/be/06/caption.jpg'},
  { name: 'Union Coffee', location: 'Minsk, Y.Kupaly street, 17',
    short_description: 'Modern European cuisine.',
    full_description: 'Union Coffee is focused on European cuisine. There are 
    also national Belarusian dishes – for example, draniki, potato pie and pancakes.
    All dishes are prepared exclusively from under the knife without the use of 
    semi-finished products. At the bar you will be offered to taste well-known cocktails,
    and with pleasure something that is not on the menu – you only have to tell
    the bartender your preferences..',
    path_to_image:
    'http://www.unioncoffee.by/media/poster.jpg'}
]

places.each do |restaurant|
  Place.create(restaurant)
end
