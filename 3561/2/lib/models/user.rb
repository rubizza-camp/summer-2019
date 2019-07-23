require 'ohm'

class User < Ohm::Model
  attribute :telegram_id
  attribute :number_in_camp
  attribute :in_camp
end
