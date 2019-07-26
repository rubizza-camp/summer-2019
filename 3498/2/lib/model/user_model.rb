class User < Ohm::Model
  STATUS = { in: true, out: false }.freeze

  attribute :telegram_id
  attribute :camp_number
  attribute :status
  index :telegram_id
  index :camp_number

  def in_camp?
    status == STATUS[:in]
  end

  def check_in
    set(:status, STATUS[:in])
  end

  def check_out
    set(:status, STATUS[:out])
  end
end
