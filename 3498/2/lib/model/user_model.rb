class User < Ohm::Model
  attribute :telegram_id
  attribute :camp_number
  attribute :status
  index :telegram_id
  index :camp_number

  include StatusManager
end
