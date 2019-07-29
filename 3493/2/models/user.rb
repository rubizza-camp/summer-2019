require 'ohm'

class User < Ohm::Model
  attribute :name
  attribute :person_number
  attribute :checkin_datetime
  attribute :checkout_datetime
  attribute :checkin?
end
