class GemEntity
  def initialize(gem_name, git_page)
    @gem_info = {}
    @gem_info[:gem_name] = gem_name
    @doc = load_doc(git_page)
    @second_doc = load_second_doc(git_page)
  end

  def count_sum
    (load_used_by.to_i + load_watched_by.to_i +
     load_forks.to_i + load_contributors.to_i) * coefficient
  end

  def print_info
    rows = []
    rows << [
      @gem_info[:gem_name], "used by #{@gem_info[:used_by]}", "watched #{@gem_info[:watched_by]}",
      "#{@gem_info[:stars]} stars", "#{@gem_info[:forks]} forks",
      "#{@gem_info[:contributors]} contributors", "#{@gem_info[:issues]} issues"
    ]
    table = Terminal::Table.new(rows: rows)
    table.style = { border_top: false, border_bottom: false }
    puts table
  end

  private

  def load_doc(page)
    Nokogiri::HTML(URI.parse(page).open)
  end

  def load_second_doc(page)
    Nokogiri::HTML(URI.parse(page + '/network/dependents').open)
  end

  def load_used_by
    @gem_info[:used_by] = @second_doc.css("a[class='btn-link selected']").text.to_s.tr('^0-9', '')
  end

  def load_watched_by
    @gem_info[:watched_by] = @doc.css('.social-count').to_a.at(0).text.strip
  end

  def load_stars
    @gem_info[:stars] = @doc.css('.social-count').to_a.at(1).text.strip
  end

  def load_forks
    @gem_info[:forks] = @doc.css('.social-count').to_a.at(2).text.strip
  end

  def load_contributors
    @gem_info[:contributors] = @doc.css("a span[class='num text-emphasized']")
                                   .to_a.at(2).text.strip ||
                               @doc.css("a span[class='num text-emphasized']")
                                   .to_a.at(3).text.strip
  end

  def load_issues
    @gem_info[:issues] = @doc.css('.Counter').to_a.at(0).text.strip
  end

  def coefficient
    load_stars.to_i / load_issues.to_i + 1
  end
end
