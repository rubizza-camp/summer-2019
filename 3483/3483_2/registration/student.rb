require 'ohm'

class Student < Ohm::Model
  attribute :number
  index :number

  attribute :status

  STATUSES = { in_camp: 'checkin', not_in_camp: 'checkout' }.freeze

  def not_in_camp?
    status == STATUSES[:in_camp]
  end

  def in_camp?
    status == STATUSES[:not_in_camp]
  end

  def left_camp
    update status: STATUSES[:in_camp]
  end

  def into_camp
    update status: STATUSES[:not_in_camp]
  end
end
