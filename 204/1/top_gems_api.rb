require 'gems'
require 'yaml'
require 'octokit'
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'terminal-table'
require 'optparse'

def opt_file
  @options = {}
  optparse = OptionParser.new do |opts|
    @options[:config_file] = nil
    @options[:name_sort] = nil
    @options[:top] = nil
    opts.on('-f', '--config-file [Array]', Array, 'Enter the config file to open.') do |file|
      @options[:config_file] = file
    end
    opts.on('-n', '--name [STRING]', String, 'Enter the config file to open.') do |name|
      @options[:name_sort] = name
    end
    opts.on('-t', '--top [INTEGER]', Integer, 'Enter the config file to open.') do |t|
      @options[:top] = t
    end
  end
  optparse.parse!
  file = if @options[:config_file].nil?
           'gems.yaml'
         else
           @options[:config_file].to_s.gsub!(/[^0-9A-Za-z.]/, '')
         end
end

def authentication
  @client = Octokit::Client.new(:access_token => "fc1076230728f91f95b4571992b36d6fa5b9930e")
  user = @client.user
  user.login
end

def yaml_parser
  thing = YAML.load_file(opt_file)
  authentication
  @gems_hash = {}
  thing.values[0].each do |name|
    gem = Gems.info(name)
    @uri = if gem['source_code_uri'].eql?(nil)
             if gem['homepage_uri'].include?('https:')
               gem['homepage_uri'].sub! 'https://github.com/', ''
             else
               gem['homepage_uri'].sub! 'http://github.com/', ''
             end
           else
             if gem['source_code_uri'].include?('https:')
               gem['source_code_uri'].sub! 'https://github.com/', ''
             else
               gem['source_code_uri'].sub! 'http://github.com/', ''
             end
           end
    user = @client.repo @uri
    doc = Nokogiri::HTML(open('https://github.com/' + @uri))
    doc_dependents = Nokogiri::HTML(open('https://github.com/' + @uri + '/network/dependents'))
    @gems_hash.merge!("#{name}": gem_stats(user))
    @gems_hash.merge!("#{name}": contributors(doc, doc_dependents))
    @gems_hash.merge!("#{name}": popularizer)
  end
end

def gem_stats(user)
  @gem_stats = {}
  @gem_stats.merge!(name: user[:name])
  @gem_stats.merge!(stargazers: user[:stargazers_count])
  @gem_stats.merge!(forks_count: user[:forks_count])
  @gem_stats.merge!(issues: user[:open_issues_count])
  @gem_stats.merge!(subscribers: user[:subscribers_count])
end

def contributors(doc, doc_dependents)
  contributors = doc.css('span.num.text-emphasized').children[2].to_s.delete('^0-9').to_i
  used_by = doc_dependents.css('.btn-link')[1].text.delete('^0-9').to_i
  @gem_stats.merge!(contributors: contributors)
  @gem_stats.merge!(used_by: used_by)
end

def popularizer
  popularity = @gem_stats.values.select { |i| Numeric === i }.reduce(:+)
  @gem_stats.merge!(popularity: popularity)
end

@keys = yaml_parser

def table(sorted_hash)
  table = Terminal::Table.new do |t|
    t.headings = ['gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues', 'popularity']
    table_hash = sorted_hash.to_h
    table_hash.to_h.keys.each do |key|
      key_hash = table_hash[key]
      t << [key, key_hash[:used_by], key_hash[:subscribers], key_hash[:stargazers], key_hash[:forks_count], key_hash[:contributors], key_hash[:issues], key_hash[:popularity]]
      t << :separator
      t.style = { border_top: false, border_bottom: false }
    end
  end
end

def name_sort
  if @options[:name_sort].eql?(nil)
    @gems_hash
  else
    @gems_hash = @gems_hash.select { |k, _v| k.match? @options[:name_sort] }
  end
end

def sorted_hash
  if @options[:top].eql?(nil)
    @gems_hash.sort_by { |_k, v| v[:popularity] }.reverse.to_h
  else
    @gems_hash.sort_by { |_k, v| v[:popularity] }.reverse.to_h.first(@options[:top])
  end
end

def result
  name_sort
  sorted_hash
  puts table(sorted_hash)
end

result
