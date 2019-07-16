require './libs/check_source_code_url.rb'
require './libs/check_github.rb'
# class for checking homepage url
class CheckURL
  def initialize(homepage_url, source_code_url)
    @homepage_url = homepage_url.to_s
    @source_code_url = source_code_url.to_s
  end

  def check_url
    check_source_url = CheckSourceCodeURL.new(@source_code_url)
    check_git_for_hp = CheckGithub.new(@homepage_url)
    return check_source_url.check_sc_url if @homepage_url.empty? || !check_git_for_hp.check_github

    @homepage_url
  end
end
