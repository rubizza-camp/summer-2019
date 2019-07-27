require 'redis-rails'
require 'fileutils'
require 'require_all'
require_rel '/utils/'

tracker = TimeTracker.new
tracker.start
