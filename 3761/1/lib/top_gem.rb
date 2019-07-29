class TopGem
  def self.call
    new.call
  end

  def call
    array_gems = gems_score.compact.sort_by! { |hash| -hash[:score] }
    TableCreator.call(array_gems, row_count(array_gems))
  end

  def gems_score
    gem_list.map do |gem_name|
      rubygems_gem_page = PageFetcher.new(gem_name, agent)
      next unless rubygems_gem_page.page_exist?
      stats(gem_name, rubygems_gem_page)
    end
  end

  def stats(gem_name, rubygems_gem_page)
    stats = GemStatisticFetcher.call(gem_name, rubygems_gem_page, agent)
    stats[:score] = GemStatisticAnalyzer.call(stats)
    stats
  end

  def row_count(array_gems)
    [args_hash[:top], array_gems.count].compact.min
  end

  private

  def gem_list
    @gem_list ||= GemListCreator.call(args_hash)
  end

  def args_hash
    @args_hash ||= ArgvParser.call
  end

  def agent
    Mechanize.new
  end
end
