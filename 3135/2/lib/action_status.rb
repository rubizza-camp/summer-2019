require_relative 'status'

# ActionStatus class manages currently ongoing action and stores their statuses to redis
class ActionStatus < Status
  def key
    @key ||= "tgid_#{tg_id}_action"
  end

  %w[registration checkin checkout].each do |name|
    define_method(name.to_s) { DB.set(key, name) }
    define_method("#{name}?") { DB.get(key) == name }
  end
end
