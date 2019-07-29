class GemDataParser
  def initialize(agent)
    @agent = agent
    @gems_stat = []
    @threads = []
    @data = []
  end

  def parse_gem_data(gems_data)
    gems_data.each do |gem_data|
      @threads << Thread.new do
        link_parse(gem_data)
      end
    end
    @threads.each(&:join)
    @gems_stat
  end

  def link_parse(gem_data)
    page = @agent.get(gem_data[:source])
    html = Nokogiri::HTML(page.content.toutf8)
    data = xpath_html(html)
    @gems_stat << data.unshift(gem_data[:gem_name])
  end

  def get_social_info(html)
    @data = html.xpath("//a[starts-with(@class, 'social-count')]")
    @data.map { |info| info.text.delete('^0-9').to_i }.uniq
  end

  def get_contributors(html)
    @data = html.xpath("//ul[@class='numbers-summary']/li/a/span").last
    @data.text.delete('^0-9').to_i
  end

  def xpath_html(html)
    social_info = get_social_info(html)
    contributors = get_contributors(html)
    open_issues = html.xpath("//span[@class='Counter']")[0].text.to_i
    social_info << contributors << open_issues
  end
end
