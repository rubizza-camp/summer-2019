%w[bundler logger yaml open-uri json time fileutils].each(&method(:require))

Bundler.require(:default)
Dir[File.join(__dir__, '**', '*.rb')].each(&method(:require))

Ohm.redis = Redic.new('redis://127.0.0.1:6379')

Bot.start
