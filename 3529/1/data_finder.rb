class DataFinder
  attr_reader :data_about_gem

  def initialize(gem_name, url, client)
    @data_about_gem = {}
    @data_about_gem[:name] = gem_name
    @url = url
    @client = client
    @repo_addr = adress_handler
  end

  def make_rate
    rate = find_watch_plus_starts + find_forks_plus_contributors
    rate + find_issues_plus_used
    @data_about_gem[:rate] = rate
  end

  private

  def adress_handler
    puts "Didn't find repository on github" unless @url
    @repo_addr = if @url.include?('https://github.com/')
                   @url.gsub('https://github.com/', '')
                 else
                   @url.gsub('http://github.com/', '')
                 end
  end

  def find_watch_plus_starts
    find_watchers
    find_stars
    @data_about_gem[:watched_by] * 0.15 + @data_about_gem[:stars] * 0.15
  end

  def find_issues_plus_used
    find_used_by
    find_issues
    @data_about_gem[:issues] * 0.05 + @data_about_gem[:used_by] * 0.5
  end

  def find_forks_plus_contributors
    find_forks
    find_contributers
    @data_about_gem[:watched_by] * 0.15 + @data_about_gem[:stars] * 0.15
  end

  def find_repository
    @client.repo(@repo_addr)
  end

  def find_forks
    @data_about_gem[:forks] = find_repository[:forks_count]
  end

  def find_stars
    @data_about_gem[:stars] = find_repository[:stargazers_count]
  end

  def find_watchers
    @data_about_gem[:watched_by] = find_repository[:subscribers_count]
  end

  def find_contributers
    contr = @client.contributors(@repo_addr)
    @data_about_gem[:contributers] = contr.length
  end

  def find_used_by
    request = Typhoeus::Request.new(@url + '/network/dependents', followlocation: true)
    request.run
    noko_obj = Nokogiri::HTML(request.response.body)
    noko_obj.css('a.btn-link.selected').each do |element|
      @data_about_gem[:used_by] = element.text[/[\d*[:punct:]]+/].tr(',', '').to_i
    end
  end

  def find_issues
    request = Typhoeus::Request.new(@url + '/issues', followlocation: true)
    request.run
    noko_obj = Nokogiri::HTML(request.response.body)
    noko_obj.css('a.btn-link.selected').each do |element|
      @data_about_gem[:issues] = element.text[/[\d*[:punct:]]+/].tr(',', '').to_i
    end
  end
end
