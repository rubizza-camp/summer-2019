require 'dotenv'
require_relative 'top_gems/top.rb'

Dotenv.load
my_top = Top.new(ENV['GITHUB_TOKEN'])
my_top.create_top
