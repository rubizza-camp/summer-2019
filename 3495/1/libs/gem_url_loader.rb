# This class collect gem url

class GemUrlLoader
  attr_reader :url, :name_to_search

  def initialize(gem_name)
    @name_to_search = gem_name
  end

  def call
    @url = gem_url
    self
  end

  def self.call(gem_name)
    new(gem_name).call
  end

  private

  def gem_url
    url_from('source_code_uri') || url_from('homepage_uri') || url_from('bug_tracker_uri') || ''
  end

  def url_from(uri)
    url = parse_gem_url(uri)
    url if (url.to_s.include? '://github.com/') && (HTTParty.get(url).code == 200)
  end

  def parse_gem_url(uri)
    Gems.info(name_to_search).values_at(uri).to_s.delete('", \, [, ]').chomp('/issues')
  end
end
