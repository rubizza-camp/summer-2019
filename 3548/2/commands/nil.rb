# by this method u can reopen u session, after consent
# to merge this program i delete him
# cobine this command with /start to kick session
module Nil
  def nil!
    id = from['id']
    redis = Redis.new(host: 'localhost')
    redis.setex(id, 1, 0)
  end
end
