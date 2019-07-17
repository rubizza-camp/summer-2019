class GemInformation
  attr_reader :array_of_information, :name
  def initialize(name:, informtion_from_api:, informtion_from_html:)
    @name = name
    @array_of_information = {}
    add_information(informtion_from_api, informtion_from_html)
  end

  private

  def add_information(information_from_api, information_from_http)
    @array_of_information = information_from_http.merge(information_from_api)
  end
end
