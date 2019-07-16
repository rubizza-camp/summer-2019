module ParseHtmlPageMethods
  def find_repo_html_url(name)
    gem_url = gem_uri(name, 'source_code_uri')
    gem_url = gem_uri(name, 'homepage_uri') if find_uri?(gem_url)
    gem_url = gem_uri(name, 'bug_tracker_uri') if find_uri?(gem_url)
    Thread.exit if gem_url == 'nil'
    gem_url
  end

  def find_fork_star_watch(url)
    result = []
    css_fork_star_watch(open_file(url)).each do |elements|
      result.push(elements.content.gsub(/[^0-9]/, ''))
    end
    result
  end

  def find_fields(url)
    result = find_fork_star_watch(url)
    result.push(css_issues(open_file(url)).content.gsub(/[^0-9]/, ''))
    result.push(css_contributers(open_file(url)).text.gsub(/[^0-9]/, ''))
  end

  def find_used_by(url)
    url += '/network/dependents'
    doc = open_file(url)
    doc.css('.btn-link').css('.selected').text.gsub(/[^0-9]/, '')
  end

  private

  def open_file(url)
    Nokogiri::HTML(Kernel.open(url))
  end

  def css_fork_star_watch(doc)
    doc.css('.social-count')
  end

  def css_issues(doc)
    doc.css('.Counter')[0]
  end

  def css_contributers(doc)
    doc.css('.num').css('.text-emphasized')[3]
  end
end
