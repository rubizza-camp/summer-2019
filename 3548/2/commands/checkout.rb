require './common/in_and_out'

# start checkout command
module Checkout
  include InAndOut

  def checkout!
    redis = Redis.new(host: 'localhost')
    id = from['id']
    check = id.to_s + 'check'
    work_out(redis, check, id)
  end
end
