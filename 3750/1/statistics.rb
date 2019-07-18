class Statistics
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def load_stats
    {
      used:         used,
      watched:      watched,
      stars:        stars,
      forks:        forks,
      contributors: contributors,
      issues:       issues
    }
  end

  private

  def html_file
    repository = Link.new(gem_name)
    main_doc(repository.link_to_repo)
  end

  def used
    repository = Link.new(gem_name)
    find_used(repository.link_to_repo)
  end

  def watched
    html_file.css('.social-count')[0].text.strip
  end

  def stars
    html_file.css('.social-count')[1].text.strip
  end

  def forks
    html_file.css('.social-count')[2].text.strip
  end

  def contributors
    html_file.css('.text-emphasized')[3].text.strip
  end

  def issues
    html_file.css('.Counter')[0].text.strip
  end

  def main_doc(link_to_repo)
    @main_doc ||= Nokogiri::HTML(URI.open(link_to_repo.to_s))
  end

  def doc_for_used_by(link_to_repo)
    @doc_for_used_by ||= Nokogiri::HTML(URI.open("#{link_to_repo}/network/dependents"))
  end

  def find_used(link_to_repo)
    used = ''
    doc_for_used_by(link_to_repo).css('.btn-link')[1].text.strip.each_line do |line|
      used = line.chomp
      break
    end
    used
  end
end
