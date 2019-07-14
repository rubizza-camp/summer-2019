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

    # :reek:TooManyStatements and :reek:NilCheck
    def parse
      @gem_names.each do |gem_name|
        parsed_response = rubygems_response(gem_name)
        source_link = parsed_response['source_code_uri']
        if !source_link.nil?
          @source_code_urls[gem_name] = source_link
        else
          puts "Can't find #{gem_name} gem GitHub repository"
        end
      end
      @source_code_urls
    end

    private

    def rubygems_response(gem_name)
      uri = URI("https://rubygems.org/api/v1/gems/#{gem_name}.json")
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
