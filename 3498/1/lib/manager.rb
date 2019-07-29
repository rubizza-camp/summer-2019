class Manager
  def initialize(options)
    @hash_table = {}
    @options = options
  end

  def parse_flag
    @parse_flag ||= @options
  end

  def count_gems_rating
    gems_list = load_yaml
    gems_list.each do |gem_name|
      find_info(gem_name)
    end
    sort_gems(@hash_table)
  rescue NoMethodError
    puts 'Error!'
  end

  private

  def load_yaml
    list = YAML.load_file(parse_flag[:file_name] || 'gems.yaml')

    if parse_flag[:word]
      list['gems'].delete_if { |gem| !gem.match?(/#{parse_flag[:word]}/) }
    else
      list.values.to_a.slice(0)
    end
  end

  def mechanize(curr_name, link_name)
    Mechanize.new.get('https://rubygems.org/gems/' + curr_name).link_with(text: link_name)
  end

  def load_page(curr_name)
    link = mechanize(curr_name, 'Source Code') ||
           mechanize(curr_name, 'Homepage')
    link.click
  rescue SocketError
    puts 'Connection failed'
  end

  def sort_gems(hash_table)
    sorted_hash = hash_table.sort_by { |_, value| -value }
    sorted_hash.take(parse_flag[:number].to_i) if parse_flag[:number]
    sorted_hash.to_h.each do |current_gem, _|
      current_gem.print_info
    end
  end

  def find_info(item_name)
    git_page = load_page(item_name)
    current_gem = GemEntity.new(item_name, git_page.uri.to_s)
    @hash_table[current_gem] = current_gem.count_sum
  end
end
