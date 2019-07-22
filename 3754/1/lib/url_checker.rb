# Class for checking if it github link or not
class UrlChecker
  attr_reader :homepage, :source_code, :bug_tracker

  def initialize(homepage, source_code, bug_tracker)
    @homepage = homepage.to_s
    @source_code = source_code.to_s
    @bug_tracker = bug_tracker.to_s
  end

  def check_url
    if homepage.include? '://github.com/'
      homepage
    elsif source_code.include? '://github.com/'
      source_code
    else
      bug_tracker.chomp!('/issues')
    end
  end
end
