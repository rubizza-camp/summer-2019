START_MESSAGE = "Привет!\n"\
                "Сейчас будет произведена регистрация пользователя.\n"\
                'Введи свой номер.'.freeze
ALREADY_REGISTERED_MESSAGE = "Ты уже зарегистрирован.\n"\
                             "Что бы “принять смену” используй “/checkin”,\n"\
                             'что бы “сдать смену” используй “/checkout”.'.freeze
MISMATCH_ERROR_MESSAGE = "Что-то пошло не так...\n"\
                         "Возможно данный номер отсутствует в списке.\n\n"\
                         'Проверь вводимую информацию, и попробуй снова "/start”.'.freeze
SUCCESSFUL_REGISTRATION_MESSAGE = "Регистрация прошла успешна.\n"\
                                  'Теперь тебе доступны действия: “принять смену” и “сдать смену”,'\
                                  ' которые вызываются командами “/checkin”'\
                                  ' и “/checkout” соответственно.'.freeze
NOT_REGISTERED_MESSAGE = "Это действие доступно после регистрации.\n"\
                         'Для регистрации используйте комманду: “/start”.'.freeze
REQUEST_PHOTO_MESSAGE = 'Пришли мне себяшку'.freeze
PHOTO_ERROR_MESSAGE = "Это на фото не похоже...\n"\
                      'Проверь, и можешь попробовать еще раз.'.freeze
REQUEST_LOCATION_MESSAGE = "Точно на месте?\n"\
                           'Пришли GPS кординаты.'.freeze
CHECKIN_SUCCESSFUL_MESSAGE = 'Отлично, порви сегодня всех. За себя и за Сашку.'.freeze
LOCATION_ERROR_MESSAGE = 'Геометка далеко от лагеря'.freeze
ALREADY_CHECKINED_MESSAGE = "Ты уже “Принял смену”.\n"\
                          'Что бы “сдать смену” используй “/checkout”.'.freeze
CHECKOUT_SUCCESSFUL_MESSAGE = "Смена сдана.\n"\
                              'Хорошо отдохнуть!'.freeze
ALREADY_CHECKOUTED_MESSAGE = "Ты еще не “Принял смену”.\n"\
                          'Что бы “принять смену” используй “/checkin”.'.freeze
