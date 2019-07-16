class HtmlReader
  def initialize(full_name)
    @name = full_name
  end

  def call
    contibuters_page = Nokogiri::HTML(open("https://github.com/#{@name}" + '/network/dependents'))
    page = Nokogiri::HTML(open("https://github.com/#{@name}"))
    { name: @name, page: page, page_for_contibuters: contibuters_page }
  end
end
