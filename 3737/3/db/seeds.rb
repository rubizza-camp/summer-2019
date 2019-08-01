restaraunts = [
  {
    name: 'Kamyanitsa',
    description: 'The restaurant “Kamyanitsa” can be safely called one
    of the most remarkable places in Minsk. This restaurant has long become a favorite place
    for those who love the Middle Ages, folk culture and national Belarusian cuisine.
    “Kamyanitsa” includes two main halls (for 35-50 persons), a bar, with its own hall,
    and a VIP room.
    One of the main halls is made in the authentic atmosphere of the Middle Ages: stone walls,
    stained glass windows, low ceilings, muted light. The other is more like a tavern with dark
    rough wooden furniture and a fireplace in the corner of the room. In this same room there is
    a mini-bar, which is made of stone and looks like a small fortress wall. Moreover, “Kamyanitsa”
    has gone beyond the usual framework of the restaurant and for five years has been one of the
    organizers and participant of the folk festival of the same name.',
    coordinate: 'Pervomayskaya street, 18'
  },
  {
    name: 'Stirlitz_spy_bar',
    description: 'In Minsk, there is the most secret and mysterious bar – Stirlitz spy bar. The
    bar is so secreted that it can not be found in directories, on the Internet or in social
    networks. Even on the official website there is no information about the whereabouts of the
    institution. It is known only that this bar is located in the center of Minsk, along
    Oktyabrskaya Street, and has neither banners nor signboards.
    The arch, the secret door, the corridor and the secret entrance – that’s how they describe
    the location of the Stirlitz bar. Owners are advised not even to try to clarify the location
    of passers-by – no one has no idea. To get to the bar, you must agree with its rules (they
    can be read on the bar’s website). Fill out the form on the site and hope that you will be
    phoned and, possibly, invited to the restaurant.',
    coordinate: 'Vitebsk street, 32'
  },
  {
    name: 'Chekhov',
    description: 'Cafe-living room “Chekhov” is a cafe in which you can also have a good rest.
    Here people communicate, play billiards, smoke together and play the piano, play solitaires
    and play chess. In a word, if you have nothing to do in the evening, you will like Chekhov.
    There are several rooms here, and people gather in everyone who have something in common.
    You can, for example, play billiards, and then go with friends in the smoking room. It often
    hosts banquets and receptions.
    Here you can also watch TV programs on a large screen with high resolution. Your ears will be
    entertained by the sounds of live music played by guest musicians. If you like privacy – at
    your disposal a small but library full of books.',
    coordinate: 'Vitebsk street, 11'
  },
  {
    name: 'Garage_Cafe',
    description: '“Garage” is a unique place where you can relax and pleasantly pass the time by
    ordering dishes of European cuisine. For working in the daytime there is a business lunch. You
    will be pleasantly surprise by the prices, and the friendly attitude of the staff of the
    establishments and excellent service will make you want to return here. This place is especiall
    popular with young people, there are daily meetings of friends and birthday parties.
    The main highlight of the cafe “Garage” is a unique interior! Just look at the ceiling lamps
    made of automobile tires!',
    coordinate: 'Umanskaya Street, 54'
  }
]

restaraunts.each do |restaraunt|
  Restaraunt.create(restaraunt)
end
