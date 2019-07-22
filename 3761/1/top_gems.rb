require 'mechanize'
require 'uri'

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

TopGem.call
