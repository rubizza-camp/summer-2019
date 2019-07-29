require 'ohm'

class User < Ohm::Model
  attribute :name
  attribute :telegram_id
  attribute :camp_id
  attribute :checkin
end
