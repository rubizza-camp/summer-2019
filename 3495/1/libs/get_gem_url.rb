# This class collect gem url

class GemUrlGetter
  attr_reader :url, :name_to_search

  def initialize(gem_name)
    @name_to_search = gem_name
    @url = gem_url
  end

  private

  def gem_url
    url_from('source_code_uri') || url_from('homepage_uri') || url_from('bug_tracker_uri') || ''
  end

  def url_from(uri)
    url = parse_gem_url(uri)
    url if url.include? '://github.com/'
  end

  def parse_gem_url(uri)
    Gems.info(name_to_search).values_at(uri).to_s.delete('", \, [, ]').chomp('/issues')
  end
end
