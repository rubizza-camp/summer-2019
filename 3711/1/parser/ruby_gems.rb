require 'net/http'
require 'json'

module Parser
  class RubyGems
    def initialize(gem_names, name_filter = nil)
      @filter = name_filter
      @gem_names = gem_names
      filter_by_name if @filter
      @source_code_urls = {}
    end

    def parse
      @gem_names.each do |gem_name|
        uri = URI("https://rubygems.org/api/v1/gems/#{gem_name}.json")
        response = Net::HTTP.get(uri)
        parsed_response = JSON.parse(response)
        @source_code_urls[gem_name] = parsed_response['source_code_uri']
      end
      @source_code_urls
    end
  end
end
