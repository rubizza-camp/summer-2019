require 'yaml'
require './git_get'

class TopGems
  attr_reader :gems_file
  attr_reader :searching_gems
  attr_reader :gems_stats
  attr_reader :settings

  def settings_new(new_settings_args)
    @settings = {}
    new_settings_args.each do |set|
      @settings[set[/\A(-*\w+)/]] = set[/[A-z0-9\.]*\z/]
    end
  end

  def initialize_threads
    threads = []
    # Starting searching threads
    @searching_gems['gems'].each do |gem|
      threads << Thread.new do
        @gems_stats << ::GitGet.new(gem).rep_inf
      end
    end
    # Waiting for searching threads ends
    threads.each(&:join)
  end

  def open_file
    file_name = @settings['--file'].nil? ? 'top_gems.rb' : @settings['--file']
    if file_name.is_a? String
      @gems_file = File.open(file_name)
      @searching_gems = YAML.safe_load(@gems_file)
    else
      puts 'wrong file name'
    end
  end

  def initialize(new_settings_args)
    settings_new new_settings_args
    open_file
    @gems_stats = []
    initialize_threads
    output_raiting
  rescue StandardError => e
    puts e.message
  end

  def sorting
    @gems_stats.sort! { |first, second| first[:score] <=> second[:score] }
    @gems_stats.reverse!
  end

  def apply_settings_name
    new_gems_stats = []
    @gems_stats.each do |gem_stats|
      new_gems_stats << gem_stats if gem_stats[:full_name].include?(@settings['--name'])
    end
    @gems_stats = new_gems_stats
  end

  def apply_settings
    # Settings --top=
    @gems_stats = @gems_stats[0..(@settings['--top'].to_i - 1)] if @settings['--top']
    # Settings --name
    apply_settings_name unless @settings['--name'].nil?
  end

  def forming_tabs
    @tabs_length_max = Hash.new { |hash, key| hash[key] = 0 }
    @gems_stats.each do |gem_stats|
      gem_stats.keys.each do |key|
        @tabs_length_max[key] = gem_stats[key].to_s.size if
          gem_stats[key].to_s.size > @tabs_length_max[key]
      end
    end
  end

  def forming_tabs_at_pos(gem_stats, symbol, where, text = nil)
    text_col = gem_stats[symbol].to_s.ljust(@tabs_length_max[symbol] + 1)
    case where
    when :start
      "#{text} #{text_col}| "
    when :end
      "#{text_col}#{text} | "
    when :none
      "#{text_col}| "
    end
  end

  def output_result
    keys = %i[name used_by watchers stargazers_count forks_count contributors open_issues_count]
    positions = %i[none start start end end end end]
    names = ['empty', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
    @gems_stats.each do |gem_stats|
      line_str = ''
      keys.each_with_index do |_item, index|
        line_str += forming_tabs_at_pos(gem_stats, keys[index], positions[index], names[index])
      end
      puts line_str
    end
  end

  def output_raiting
    sorting
    apply_settings
    forming_tabs
    output_result
  end
end

# Initialization start with ARGV-settings
TopGems.new ARGV
