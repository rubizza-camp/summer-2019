require_relative 'html_method'

module  Functions
  class GemManager
    attr_reader :file_name, :name_gem, :top_count, :gem_hash
    HIGHEST_COEF = 3
    MEDIUM_COEF = 2
    LOW_COEF = 1

    include HtmlMethod

    def initialize(file_name, name_gem, top_count)
      @gem_hash = {}
      @file_name = file_name
      @name_gem = name_gem
      @top_count = top_count
    end

    def call
      parse_gem_info
      print_table
    end

    private

    def extract_gems_from_yaml(file_name)
      file = YAML.load_file(file_name)
      file['gems']
    end

    def gem_uri(name, uri_path)
      Gems.info(name).values_at(uri_path).to_s.delete('", \, [, ]').chomp('/issues')
    end

    def find_uri?(gem_url)
      (gem_url == 'nil') || !(gem_url.include? 'https://github.com/') && !(gem_url.include? 'http://github.com/')
    end

    def print_table
      rows = []
      gem_hash.each { |_key, value| rows << value.strings }
      table = Terminal::Table.new rows: rows
      puts table
    end

    def collect_gem_data(gem)
      url = find_repo_html_url(gem)
      gem_object = Models::GemModel.new(gem, url)
      gem_object.install_fields(find_fields(url))
      gem_object.count_used_by = find_used_by(url)
      gem_object
    end

    def valid_gem?(gem)
      gem =~ /#{name_gem}/
    end

    def create_thread(gem)
      Thread.new { @gem_hash[gem] = collect_gem_data(gem) }
    end

    def collect_thread
      threads = []
      extract_gems_from_yaml(file_name).each do |gem|
        next unless valid_gem?(gem)
        threads << create_thread(gem)
      end
      threads
    end

    def parse_gem_info
      collect_thread.each(&:join)
      choose_top_gem if top_count > 0
    end

    def calculate_score(gem_hash)
      HIGHEST_COEF * gem_hash[:count_used_by] +
        MEDIUM_COEF * gem_hash[:count_watched] * gem_hash[:count_stars] * gem_hash[:count_forks] +
        LOW_COEF * gem_hash[:count_contributors] * gem_hash[:count_issues]
    end

    def sort_gem(score)
      score.sort_by { |_key, value| value }.last(top_count)
    end

    def group_score
      score = {}
      gem_hash.each do |key, value|
        hash = value.fields
        score[key] = calculate_score(hash.slice(:count_used_by, :count_watched, :count_stars,
                                                :count_forks, :count_contributors, :count_issues))
      end
      score
    end

    def choose_top_gem
      total_hash = {}
      sort_gem(group_score).each { |elem| total_hash[elem[0]] = gem_hash[elem[0]] }
      @gem_hash = total_hash
    end
  end
end
