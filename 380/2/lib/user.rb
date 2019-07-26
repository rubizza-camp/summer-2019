class User
  def self.find(tg_id)
    camp_id = Redis.current.get("users:#{tg_id}")
    status = Redis.current.get("users:#{tg_id}:status")
    user = new(tg_id, camp_id)
    user.status = status
    user
  end

  def self.create(tg_id, camp_id)
    user = new(tg_id, camp_id)
    user.save_camp_number
    user
  end

  def self.check_in(tg_id)
    user.check_in
  end

  attr_reader :camp_id, :tg_id

  def initialize(tg_id, camp_id = nil)
    @camp_id = camp_id
    @tg_id = tg_id
  end

  state_machine :status, initial: :not_registered do
    after_transition do |user, transition|
      user.save_status(transition)
    end

    after_transition on: :save_camp_number do |user, _|
      Redis.current.set("users:#{user.tg_id}", user.camp_id)
    end

    event :register do
      transition not_registered: :waiting_for_number
    end

    event :save_camp_number do
      transition waiting_number: :checked_out
    end

    event :check_out do
      transition [:checked_in, :waiting_selfie, :waiting_geo] => :checked_out
    end

    event :check_in do
      transition checked_out: :waiting_selfie
    end

    event :save_selfie do
      transition waiting_selfie: :waiting_geo
    end

    event :save_geo do
      transition waiting_geo: :checked_in
    end
  end
  def save_status(transition)
    Redis.current.set("users:#{self.tg_id}:status", transition.to)
  end
end
