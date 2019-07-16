require_relative 'top_gems_finder'

searcher = TopGemsFinder.new('gems')

puts searcher.search
