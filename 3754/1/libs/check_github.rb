# class for checking github url
class CheckGithub
  def initialize(url)
    @url = url
  end

  def check_github
    @url.include? 'github.com'
  end
end
