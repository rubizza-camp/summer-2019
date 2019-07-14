# This class collect gem url
#:reek:InstanceVariableAssumption:
class GemUrlGetter
  attr_reader :gem_url
  def initialize(gem_name)
    @gem_for_search = gem_name
  end

  def gem_url_with_source_code_uri
    gem_url_with_homepage_uri if check_valid_url(gem_url_parse('source_code_uri'))
  end

  def gem_url_with_homepage_uri
    gem_url_with_bug_tracker_uri if check_valid_url(gem_url_parse('homepage_uri'))
  end

  def gem_url_with_bug_tracker_uri
    return nil if check_valid_url(gem_url_parse('bug_tracker_uri'))
  end

  def gem_url_parse(content)
    @gem_url = Gems.info(@gem_for_search).values_at(content).to_s.delete('", \, [, ]').chomp('/issues')
  end

  def check_valid_url(*)
    (HTTParty.get(@gem_url).code != 200) || !(@gem_url.include? '/github.com/')
  end
end
