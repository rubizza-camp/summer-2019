require 'yaml'
require 'httparty'
require 'json'
require 'table_print'
require_relative './opt.rb'
require_relative './gem_info.rb'
require_relative './cli.rb'

options = OptparseScript.parse
@gems_array = GemScorer::Cli.new.call(options)
