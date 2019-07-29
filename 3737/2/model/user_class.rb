require 'ohm'

# user model
class User < Ohm::Model
  attribute :number
  attribute :in_camp

  def self.registered?(id)
    self[id]
  end
end
