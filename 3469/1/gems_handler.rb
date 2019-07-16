class GemsHandler
  include IoStream
  def initialize(key)
    @key = key
    @array_of_top_gems = []
    @parameters = {}
    @array_of_gems = []
  end

  def call
    gems_names = information_from_file
    input_data
    start_search(gems_names)
    sort_the_information
    print_top(@array_of_top_gems)
  end

  private

  def start_search(gems_names)
    gems_names.map do |name_of_gem|
      info_from_api  = ApiParser.new(@key).call(name_of_gem)
      info_from_html = HtmlParser.new(HtmlReader.new(info_from_api[:full_name]).call).call
      @array_of_top_gems << GemInformation.new(
        name: name_of_gem, informtion_from_api: info_from_api, informtion_from_html: info_from_html
      )
    end
  end

  def sort_the_information
    @array_of_top_gems.sort_by { |gem| -gem.array_of_information[:score] }
  end
end
