require 'dotenv'
# frozen_string_literal: true

Dotenv.load
TOKEN = ENV['TOKEN']

API_URL_TELEGRAM = "https://api.telegram.org/bot#{TOKEN}/"
API_URL_TELEGRAM_FILE = "https://api.telegram.org/file/bot#{TOKEN}/"
GET_FILE_URL = 'getFile?file_id='

VALID_LATITUDE = 53.914264..53.916233
VALID_LONGITUDE = 27.565941..27.571306

DATA_PATH = './data/numbers.yml'

# answers for user

NOT_REGISTER = 'You are not registered'
NO_IN_THE_LIST = 'Don\'t know student with this number'
SUCCESSFUL_REGISTRATION = 'You can continue with /checkin, /checkout'
GEOLOCATION = 'Send me your geolocation'
PHOTO = 'Send me your photo, please'
NOT_PHOTO = 'Are you sure that it is photo???'
REGISTERED = "You've already registered!"
GREAT = 'GREAT!!!'
NOT_AT_WORK = 'You must be on work'
SUCCESSFUL_CHECK = 'Have a good day'
DELETE = 'I deleted you'
