require 'gems'
require 'yaml'
require 'octokit'
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'terminal-table'
require 'optparse'

def opt_file
  options = {}
  optparse = OptionParser.new do |opts|
    options[:config_file] = nil
    opts.on('-f', '--config-file', 'Enter the config file to open.') do
      options[:dry_run] = true
    end
  end
  parsing_file = optparse.parse!
  if parsing_file.empty?
    file = 'gems.yaml'
  else
    file = parsing_file.to_s.gsub!(/[^0-9A-Za-z.]/, '')
  end
  file
end

def authentication
  puts 'Введите Github account'
  @username = gets.chomp
  puts 'Введите пароль'
  @password = gets.chomp
end

def yaml_parser
  thing = YAML.load_file(opt_file)
  client = Octokit::Client.new(login: 'drujok', password: '33motina')
  @gems_hash = {}
  thing.values[0].each do |name|
    gem = Gems.info(name)
    gem_uri = gem['source_code_uri'].sub! 'https://github.com/', ''
    user = client.repo gem_uri
    doc = Nokogiri::HTML(open('https://github.com/' + gem_uri))
    @gems_hash.merge!("#{name}": gem_stats(user))
    @gems_hash.merge!("#{name}": contributors(doc))
  end
end

def gem_stats(user)
  @gem_stats = {}
  @gem_stats.merge!(name: user[:name])
  @gem_stats.merge!(stargazers: user[:stargazers_count])
  @gem_stats.merge!(forks_count: user[:forks_count])
  @gem_stats.merge!(issues: user[:open_issues_count])
  @gem_stats.merge!(subscribers: user[:subscribers_count])
  @gem_stats.merge!(used_by: '')
end

def contributors(doc)
  contributors = doc.css('span.num.text-emphasized').children[2].to_s.delete('^0-9').to_i
  @gem_stats.merge!(contributors: contributors)
end

@keys = yaml_parser

def table
  table = Terminal::Table.new do |t|
    t.headings = ['gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
    hash =
      @gems_hash.keys.each do |key|
        key_hash = @gems_hash[key]
        t << [key, key_hash[:used_by], key_hash[:subscribers], key_hash[:stargazers], key_hash[:forks_count], key_hash[:contributors], key_hash[:issues]]
        t << :separator
        t.style = { border_top: false, border_bottom: false }
      end
  end
end

def final
  puts table
end

final
