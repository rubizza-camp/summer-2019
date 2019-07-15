require_relative './scores.rb'
module GemScorer
  class Cli
    def call(options)
      @list = load_gemlist(options[:file])
      @gem_names = find_match(@list, options[:name])
      @gems_array = get_gems(@gem_names)
      calculate_scores(@gems_array)
      @gems_array.sort_by!(&:popularity).reverse!
      @gems_array = take_top(@gems_array, options[:top])
      tp @gems_array, :name, { used_by: { display_name: 'used by' } },
         { watch: { display_name: 'Watched By' } },
         :star, :fork, { contrib: { display_name: 'Contributors' } },
         :issues
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
        gem_inst.criterias
        gem_inst.contribs
        @gems_array << gem_inst
      end
      @gems_array
    end

    def calculate_scores(array)
      ::Score.new.call(array)
    end
  end
end
