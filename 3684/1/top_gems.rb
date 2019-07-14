require_relative 'gem_searcher'

searcher = GemSearch.new('gems.yaml')

puts searcher.search
