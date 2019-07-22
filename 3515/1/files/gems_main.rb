class WorkWithGems
  attr_reader :threads
  attr_reader :gems_from_file
  attr_reader :gems_for_term_table
  attr_reader :length

  def start(file = 'gems.yml')
    define_gems_vars(file)
    iterating_gems_array
    threads.each(&:join)
  end

  def define_gems_vars(file)
    @gems_from_file = GemsLoaderFromFile.new(file)
    @length = gems_from_file.length
    @gems_for_term_table = []
    @threads = []
  end

  def iterating_gems_array
    gems_from_file.gems_from_file.each do |gem_name|
      threads << Thread.new(gem_name) do
        gem_url = GemsUrlLoader.new(gem_name)
        next unless gem_url.url.include?('http')

        get_gem_parameters(gem_url.url, gem_name)
      end
    end
  end

  def get_gem_parameters(gem_url, gem_name)
    gem_params = GemParamGetter.new
    gems_for_term_table << gem_params.define_variables(gem_url, gem_name)
  end

  def terminal_table_builder(len = length)
    TerminalTable.new(gems_for_term_table, len)
  end
end
