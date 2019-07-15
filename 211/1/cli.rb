module GemScorer

  class Cli
  
    def call(options)
      @list = load_gemlist(options[:file])
      @gem_names = find_match(@list, options[:name])
      @gems_array = get_gems(@gem_names)
      # scores = calculate_scores(gem_info)
      # print_result(scores)
    end
  
    def load_gemlist(file = nil)
      file ||= 'gem_list.yml'
      begin
        YAML.safe_load(File.read(file))
      rescue Errno::ENOENT
        puts 'file must exist'
        exit
      end
    end
    
    def find_match(list, name = nil)
      name ||= '\w+'
      list['gems'].find_all { |g| g.match(name) }
    end
    
    def take_top(arr, top = nil)
      top ||= arr.size
      begin
        arr.take(top)
      rescue ArgumentError
        puts 'top must be positive'
        exit
      end
    end 

    def get_gems(names)
      @gems_array = []
      names.each do |gem_n|
        gem_inst = GemInfo.new(gem_n)
        gem_inst.set_criteria
        @gems_array << gem_inst
      end
      @gems_array
    end 
  
  end
end
