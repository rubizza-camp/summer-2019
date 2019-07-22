require_relative 'top_gems_creator'

searcher = TopGemsCreator.new('gems.yml')

puts searcher.create
