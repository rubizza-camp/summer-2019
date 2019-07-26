require 'aasm'

class User
  include AASM

  def self.find(tg_id)
    camp_id = Redis.current.get(tg_id)
    puts "self.find(#{tg_id})"
    puts "Redis.current.get(tg_id) #{camp_id}"
    puts "Redis.current.get(camp_id) #{Redis.current.get(camp_id)}"
    user = new(tg_id, camp_id)
    puts "user.status: #{user.status}"
    user
  end

  def self.create(tg_id, camp_id)
    user = new(tg_id, camp_id)
    Redis.current.set(tg_id, camp_id)
    user
  end

  attr_reader :camp_id, :tg_id

  def status
    Redis.current.get(camp_id)
  end

  def initialize(tg_id, camp_id = nil)
    @camp_id = camp_id
    @tg_id = tg_id
  end

  def save_status
    puts "transitions #{aasm.current_state}"
    Redis.current.set(camp_id, aasm.current_state)
  end

  aasm do
    state :waiting_for_number
    state :checked_out
    state :waiting_for_selfie
    state :waiting_for_geo
    state :check_in

    after_all_events :save_status

    event :waiting_for_number do
      transitions to: :waiting_for_number
    end

    event :checked_out do
      transitions from: [:waiting_for_number, :checked_in], to: :checked_out
    end

    event :waiting_for_selfie do
      transitions from: :checked_out, to: :waiting_for_selfie
    end

    event :waiting_for_geo do
      transitions from: :waiting_for_selfie, to: :waiting_for_geo
    end

    event :checked_in do
      transitions from: :waiting_for_geo, to: :checked_in
    end

    event :unregister do
      transitions from: :checked_out, to: :not_registred
    end
  end
end
