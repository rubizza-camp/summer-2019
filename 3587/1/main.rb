require 'mechanize'
require 'optparse'
require 'terminal-table'

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

TopGem.perform
