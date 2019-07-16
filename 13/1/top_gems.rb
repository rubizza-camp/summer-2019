require 'yaml'
require 'nokogiri'
require 'gems'
require 'rubygems'
require 'httparty'
require 'terminal-table'
require 'optparse'

class TopRubyGems

	attr_accessor :hash_of_gems, :collection_size, :gem_to_show, :path_to_gem_list

	def initialize
		@collection_size = 0
		@gem_to_show = ''
		@path_to_gem_list = ''
		@urls = {}
		@hash_of_gems = {}
		@total_data_about_gem = {}
	end

	def get_params_from_term
		unless ARGV == nil
			@options = {}
			optparse = OptionParser.new do |opts|
  	  	opts.on("-n", "--name [STRING]", String, "Run verbosely") { |args| @options[:input_name] = args.strip.chomp }
				opts.on('-t', '--top= [STRING]', Integer, "Run verbose") { |args| @options[:input_qty] = args.strip.chomp }
				opts.on('-f', '--file= [INTEGER]', Integer, "Run verbose") { |args| @options[:input_path_to_file] = args.strip.chomp }
			end
  		optparse.parse!
  		@options
  	end
	end

	def get_data_from_yaml_to_hash
		@list_of_gems_in_yml = YAML.safe_load(File.read('data/gems.yml'))
		@list_of_gems_in_yml['gems'].each do |_gem_|
		_gem_.downcase!
		@hash_of_gems[_gem_] = Gems.info _gem_
		end
	end

	def create_hash_with_urls_for_parcing
		@hash_of_gems.each do |key, value|
			if @hash_of_gems[key]['source_code_uri']
				@urls[key] = @hash_of_gems[key]['source_code_uri']
					if @hash_of_gems[key]['source_code_uri'][4] == ':' 
					@urls[key] = @hash_of_gems[key]['source_code_uri'].insert(4, 's')
					end
			else
				@urls[key] = @hash_of_gems[key]['homepage_uri']
					if @hash_of_gems[key]['homepage_uri'][4] == ':' 
					@urls[key] = @hash_of_gems[key]['homepage_uri'].insert(4, 's')
					end
				end
			end
	end

	def preparing_url_and_parsing(url_for_parsing, key_css_tag)
		unparced_url = HTTParty.get(url_for_parsing)
		parced_url = Nokogiri::HTML(unparced_url)
		page_for_searching = parced_url.css("#{key_css_tag}").text
		page_for_searching = page_for_searching.delete(',')
		return page_for_searching
	end

	def get_and_parsing_data
		get_data_from_yaml_to_hash
		create_hash_with_urls_for_parcing

		@urls.each do |key, value|
			@watches = preparing_url_and_parsing(@urls[key], 'a.social-count').strip.to_i

			@used_by = preparing_url_and_parsing(@urls[key] + '/network/dependents', 'div.table-list-header-toggle').delete(' ').strip
			@used_by = /\d+/.match(@used_by).to_s.to_i

			@stars = preparing_url_and_parsing(@urls[key], 'a.social-count').delete(' ').strip
			@stars = /\n\n\d+\n\n/.match(@stars)
			@stars =  @stars.to_s.strip.to_i * 10

			@forks = preparing_url_and_parsing(@urls[key], 'a.social-count').delete(' ').strip
			@forks = /\n\n\d+\Z/.match(@forks)
			@forks = @forks.to_s.strip.to_i

			@contributors = preparing_url_and_parsing(@urls[key], 'ul.numbers-summary').delete(' ').strip
			@contributors = /\n\d+\n\ncontr/.match(@contributors)
			@contributors = @contributors.to_s.strip.delete('contr').strip.to_i

			@issues = preparing_url_and_parsing(@urls[key] + '/issues', 'div.table-list-header-toggle:nth-child(1)').delete(' ').strip
			@issues = /\A\d+/.match(@issues).to_s.to_i

			@rank_of_gem = @watches + @used_by + @stars + @forks + @contributors - @issues  

			@total_data_about_gem[key] = {
									name: key,
									watches: @watches,
									used_by: @used_by,
									stars: @stars,
									forks: @forks,
									contributors: @contributors,
									issues: @issues,
									rank: @rank_of_gem
								}
		end
	end

	def show_top_ruby_gems
		@total_data_about_gem.sort_by { |_k, value| value[:stars]}.reverse.to_h
	end

	def show_table_with_all_gems
		show_greeting
		@rows = []
		show_top_ruby_gems.each do |key, value|
			@rows << ["#{@total_data_about_gem[key][:name]}" ,
				"used by #{@total_data_about_gem[key][:used_by]}",
			 	"watched by #{@total_data_about_gem[key][:watches]}",
			 	"#{@total_data_about_gem[key][:stars]}  stars",
			 	"#{@total_data_about_gem[key][:forks]}  forks",
			 	"#{@total_data_about_gem[key][:contributors]}  contributors",
			 	"#{@total_data_about_gem[key][:issues]}  issues"]
			end
		table = Terminal::Table.new :rows => @rows
		puts table
		3.times { puts '' }
	end

	def show_gems_in_table
		if @options[:input_qty].nil?
			show_table_with_all_gems
		else


		end
	end

	def show_greeting
		3.times { puts '' }
		puts '------------------ R   U   B   Y ---- T   O  P ---- G   E   M   S ------ V 0.1 ----------------------------------'
		3.times { puts '' }
	end
end

start_programm = TopRubyGems.new
start_programm.get_data_from_yaml_to_hash
start_programm.get_and_parsing_data
start_programm.show_table_with_all_gems


