require './common/in_and_out'

# start checkin command
module Checkin
  include InAndOut

  def checkin!
    redis = Redis.new(host: 'localhost')
    id = from['id']
    check = id.to_s + 'check'
    work_in(redis, check, id)
  end
end
