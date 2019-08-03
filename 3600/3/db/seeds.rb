# frozen_string_literal: true

descriptions = [
  { name: "The Spaniards Inn.",
    address: 'Spaniards Road, Hampstead, London, Greater London, NW3 7JJ',
    short_description: 'Gastropub, British, European, $$',
    full_description: 'It has the feeling of a country pub (and is especially cosy in win'\
    'ter) but is very much a part of the city, even getting a mention in Dickens’s The Pick'\
    'wick Papers.' },
  { name: 'The Marksman',
    address: '254 Hackney Road, London, England, E2 7SJ, United Kingdom',
    short_description: 'Pub, British, $$',
    full_description: 'Serving great local beers, ales, lagers and ciders alongside a selec'\
    'tion of fine wines and spirits. We have a bar menu and an exceptional restaurant' },
  { name: 'Ye Olde Cheshire Cheese',
    address: '145 Fleet Street, London, England, EC4A 2BU, United Kingdom',
    short_description: 'Pub, British, $$',
    full_description: 'Ye Olde Cheshire Cheese is a Fleet Street institution, having been stan'\
    'ding since just after the Great Fire of London when it was rebuilt (and there was a pub '\
    'on the same site before that, too)' },
  { name: 'The Harwood Arms',
    address: ' Walham Grove, Fulham, London, England, SW6 1QP, United Kingdom',
    short_description: 'Gastropub, British, $$$',
    full_description: 'As The Harwood Arms holds a Michelin star (the only pub in the capital '\
    'to currently have one) and is co-owned by Brett Graham of The Ledbury, it’s clearly a very '\
    'good place to come and eat. They really focus on using the best ingredients from top sup'\
    'pliers, including game when it’s in season. Throw in their extensive wine list, and it’s '\
    'also a great place to come and drink.' },
  { name: 'Lamb & Flag',
    address: ' Walham Grove, Fulham, London, England, SW6 1QP, United Kingdom',
    short_description: 'Pub, British, $$',
    full_description: 'Given its prime location in Covent Garden, the Lamb & Flag can get very '\
    'busy, but its worth putting up with the crowds because it’s a real gem of a pub. It has '\
    'plenty of history, even gaining a reputation for bare-knuckle brawling in the 19th cen'\
    'tury, and it doesnt feel like much has changed inside over the years. As well as plenty '\
    'of ales and beers behind the bar, the Lamb & Flag also has a strong whisky collection if '\
    'you fancy something stronger.' }
]

descriptions.each do |place|
  Restaurant.create(place)
end
