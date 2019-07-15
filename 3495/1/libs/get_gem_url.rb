# This class collect gem url
# :reek:RepeatedConditional
# :reek:UtilityFunction
class GemUrlGetter
  attr_reader :gem_url
  attr_reader :gem_for_search

  def initialize(gem_name)
    @gem_for_search = gem_name
    @gem_url = find_by_source_code_uri
  end

  private

  def find_by_source_code_uri
    url = parse_gem_url('source_code_uri')
    check_valid_url(url) ? find_by_homepage_uri : url
  end

  def find_by_homepage_uri
    url = parse_gem_url('homepage_uri')
    check_valid_url(url) ? find_by_bug_tracker_uri : url
  end

  def find_by_bug_tracker_uri
    url = parse_gem_url('bug_tracker_uri')
    check_valid_url(url) ? nil : url
  end

  def parse_gem_url(uri)
    Gems.info(@gem_for_search).values_at(uri).to_s.delete('", \, [, ]').chomp('/issues')
  end

  def check_valid_url(url)
    !(url.include? '://github.com/') || (HTTParty.get(url).code != 200)
  end
end
