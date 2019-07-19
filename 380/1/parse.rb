require 'nokogiri'
require 'Gems'
require 'octokit'

module Parse
  def parse_options
    options = {}
    OptionParser.new do |parse|
      parse.on('-t', '--top [top]', Integer, 'Enter count of gems in top:') do |top|
        puts "asdasdasd #{top.class}"
        options[:top] = top if top
      end
      parse.on('-f', '--file [file]', String, 'Enter your yml file:') do |file|
        options[:file] = file if file
      end
      parse.on('-n', '--name [STRING]', String, 'Enter gem you need:') do |name|
        options[:name] = name if name
      end
    end.parse!
    options
  end

  def parse_file(file = 'gems.yml')
    puts file
    YAML.load_file(file)['gems']
  rescue Errno::ENOENT
    raise "No file '#{file}' in such derictory!"
  end

  def parse_uri_of(gem)
    info = Gems.info(gem)
    if info != {}
      url = info['source_code_uri'] || info['homepage_uri'] # .sub!(%r{http.*com/}, '')
      url.sub!(/https\:\/\/github.com\//, '') if url.include? 'https://github.com/'
      url.sub!(/http\:\/\/github.com\//, '')  if url.include? 'http://github.com/'
      puts url
      url = url.split('/')
      {
        user: url[0],
        repo: url[1]
      }
    else
      puts "No information about <#{gem}> on rubygems."
      nil
    end
  end

  def parse_page_info(uri)
    url = 'https://github.com/' + uri[:user] + '/' + uri[:repo]
    cons = Nokogiri::HTML(open(url)).css('span.num.text-emphasized').children[2].text.to_i
    url += '/network/dependents'
    used_by = Nokogiri::HTML(open(url)).css('.btn-link')[1].text.delete('^0-9').to_i
    {
      contributors: cons,
      used_by: used_by
    }
  end

  def parse_api_info(gem_link)
    client.repo gem_link
  rescue Octokit::InvalidRepository
    raise 'Invalid as a repository identifier.'
  end

  def parse_from(api_info, page_info)
    {
      name: api_info[:name],
      stargazers: api_info[:stargazers_count],
      forks_count: api_info[:forks_count],
      issues: api_info[:open_issues_count],
      subscribers: api_info[:subscribers_count],
      contributors: page_info[:contributors],
      used_by: page_info[:used_by]
    }
  end
end
