require_relative 'sort_gems.rb'

class GithubHtmlParser
  class << self
    def perform(first_part, contrib, issues, used_by)
      gems_param = {}
      gems_param['used_by'] = used_by
      fill_first_part(gems_param, first_part)
      gems_param['issues'] = issues
      gems_param['contrib'] = contrib.text.strip.to_i
      gems_param
    end

    private

    def fill_first_part(gems_param, first_part)
      gems_param['watch'] = first_part[0].text.strip
      gems_param['star'] = first_part[1].text.strip
      gems_param['fork'] = first_part[2].text.strip
      delete_words(gems_param)
    end

    def delete_words(gems_param)
      gems_param['watch'] = gems_param['watch'].delete('Watch').to_i
      gems_param['star'] = gems_param['star'].delete('Star').to_i
      gems_param['fork'] = gems_param['fork'].delete('Fork').to_i
      gems_param
    end
  end
end
