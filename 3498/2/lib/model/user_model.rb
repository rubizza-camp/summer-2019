class User < Ohm::Model
  STATUS = %w[in out].freeze

  attribute :telegram_id
  attribute :camp_number
  attribute :status

  def in_camp?
    status == 'in'
  end
end
