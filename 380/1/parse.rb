require 'nokogiri'
require 'Gems'
require 'octokit'

module Parse
  def parse_options
    options = {}
    OptionParser.new do |parse|
      parse.on('-t', '--top [top]', Integer, 'Enter count of gems in top:') do |top|
        options[:count] = top if top
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

  def parse_file_with(file, name)
    file = 'gems.yml' if file.nil?
    gem_list = YAML.load_file(file)['gems']
    unless name.nil?
      gem_list.select.with_index { |item, index| gem_list.pop(index) unless item.include?(name) }
    end
    gem_list
  rescue Errno::ENOENT
    raise "No file '#{file}' in such derictory!"
  end

  def rubygems_response(gem)
    if Gems.info(gem) == {}
      puts "No information about <#{gem}> on rubygems."
    else
      Gems.info(gem)
    end
  end

  def gem_info(gem_hash, client)
    repo_id = parse_uri_of(gem_hash)
    { page: parse_page_info(repo_id), api: api_info(client, repo_id) }
  end

  def parse_page_info(repo_id)
    url = 'https://github.com/' + repo_id[:user] + '/' + repo_id[:repo]
    cons = Nokogiri::HTML(open(url)).css('span.num.text-emphasized').children[2].text.to_i
    url += '/network/dependents'
    used_by = Nokogiri::HTML(open(url)).css('.btn-link')[1].text.delete('^0-9').to_i
    { contributors: cons, used_by: used_by }
  end

  def api_info(client, repo_id)
    client.repo repo_id
  rescue Octokit::InvalidRepository
    raise 'Invalid as a repository identifier.'
  end

  def parse_uri_of(info)
    return nil unless info != {}
    url = (info['source_code_uri'] || info['homepage_uri']).split('/')
    { user: url[3], repo: url[4] }
  end
end
