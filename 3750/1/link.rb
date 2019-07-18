class Link
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def link_to_repo
    return source_code_link.href if source_code_link
    homepage_link.href
  end

  private

  def page
    agent = Mechanize.new
    agent.get("https://rubygems.org/gems/#{@gem_name}")
  end

  def source_code_link
    page.links.find { |link| link.text == 'Source Code' }
  end

  def homepage_link
    page.links.find { |link| link.text == 'Homepage' }
  end
end
