require_relative 'status'

# RequestStatus class manages current requests and stores their statuses to redis
class RequestStatus < Status
  def key
    @key ||= "tgid_#{tg_id}_request"
  end

  %w[camp_num photo location].each do |name|
    define_method(name.to_s) { DB.set(key, name) }
    define_method("#{name}?") { DB.get(key) == name }
  end
end
