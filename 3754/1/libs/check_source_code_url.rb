require './libs/check_github.rb'
# class for checking source code url
class CheckSourceCodeURL
  def initialize(source_code_url)
    @source_code_url = source_code_url
  end

  def check_sc_url
    check_git_for_sc = CheckGithub.new(@source_code_url)
    return false if @source_code_url.empty? || !check_git_for_sc.check_github

    @source_code_url
  end
end
