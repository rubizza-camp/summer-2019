require_relative 'gem_sorter.rb'

class GithubHtmlParser
  class << self
    def perform(arr_watch_star_fork, contrib, issues, used_by)
      gems_param = {}
      fill_arr_watch_star_fork(gems_param, arr_watch_star_fork)
      gems_param['used_by'] = used_by
      gems_param['issues'] = issues
      gems_param['contrib'] = contrib
      gems_param
    end

    private

    def fill_arr_watch_star_fork(gems_param, arr_watch_star_fork)
      gems_param['watch'] = arr_watch_star_fork[0].text.strip
      gems_param['star'] = arr_watch_star_fork[1].text.strip
      gems_param['fork'] = arr_watch_star_fork[2].text.strip
      delete_words(gems_param)
    end

    def delete_words(gems_param)
      gems_param.each_key do |key|
        gems_param[key] = gems_param[key].gsub(/[^0-9]/, '').to_i
      end
    end
  end
end
