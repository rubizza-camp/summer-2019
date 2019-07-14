require_relative 'test'
require_relative 'auxiliary'

class Gems
    attr_reader :name, :github, :stats, :rating, :response

    def initialize(name)
      @name = name
      @response = call_rubygems_api
      @github = github_link
      @rating = downloads_stat
      @stats = github_parse
    end

    private
    include DataCollect
end

#a = Gems.new('rubygems-update')
#puts a.response

#gems_array = []
#load_gems.each { |gem_name| gems_array << Gems.new(gem_name) }
#gems_array.each { |gem| puts gem.github }
gem1 = Gems.new('sinatra')
puts gem1.stats