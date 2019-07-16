require 'rubygems'
require 'open-uri'
require 'nokogiri'
#:reek:InstanceVariableAssumption
class GemInfo
  def get_array(gem_name)
    @mass = []
    get_all(gem_name)
    @mass.flatten!.push(gem_name)
  end

  private

  def gem_search(gem_name)
    url = "https://rubygems.org/gems/#{gem_name}"
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    doc.xpath('//a[@id="code"]/@href')
  end

  def open_first_url(gem_name)
    url = gem_search(gem_name).to_s
    html = URI.open(url)
    Nokogiri::HTML(html)
  end

  def open_second_url(gem_name)
    url = "#{gem_search(gem_name)}/network/dependents"
    html = URI.open(url)
    Nokogiri::HTML(html)
  end

  def get_star_forf_whatch(gem_name)
    star_forf_whatch =
      open_first_url(gem_name).css('a[class *="social-count"]').text.scan(/[0-9,]+/)
    @mass << star_forf_whatch
  end

  def get_issues(gem_name)
    issues =
      open_first_url(gem_name).at_css('span[class *="Counter"]').text.scan(/[0-9,]+/)
    @mass << issues
  end

  def get_contributors(gem_name)
    contributors =
      open_first_url(gem_name).css('span[class *="num text-emphasized"]').text.scan(/[0-9,]+/)
    @mass << contributors.last
  end

  def get_used_by(gem_name)
    used_by = open_second_url(gem_name).css('a[class *="btn-link selected"]').text.scan(/[0-9,]+/)
    @mass << used_by
  end

  def get_all(gem_name)
    get_used_by(gem_name)
    get_star_forf_whatch(gem_name)
    get_issues(gem_name)
    get_contributors(gem_name)
  end
end
