require './parse_html_page_methods'
require './score_methods'
require './print_table'

module ObjectManagers
  class GemControl
    include ParseHtmlPageMethods
    include ScoreMethods

    attr_reader :file_name, :gem_name, :top_count, :gem_hash

    def initialize(file_name, gem_name, top_count)
      @gem_hash = {}
      @file_name = file_name
      @gem_name = gem_name
      @top_count = top_count
    end

    def self.call(file_name, gem_name, top_count)
      new(file_name, gem_name, top_count).call
    end

    def call
      parse_gem_info
      PrintTable.call(gem_hash)
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
      !(gem_url.include? 'https://github.com/') && !(gem_url.include? 'http://github.com/')
    end

    def collect_gem_data(gem)
      url = find_repo_html_url(gem)
      gem_object = Models::GemInfo.new(gem, url)
      gem_object.install_fields(find_fields(url))
      gem_object.save_count_used_by(find_used_by(url))
      gem_object.gem_hash
    end

    def valid_gem?(gem)
      gem =~ /#{gem_name}/
    end

    def create_thread(gem)
      Thread.new { @gem_hash[gem] = collect_gem_data(gem) }
    end

    def group_thread
      threads = []
      extract_gems_from_yaml(file_name).each do |gem|
        next unless valid_gem?(gem)
        threads << create_thread(gem)
      end
      threads
    end

    def parse_gem_info
      group_thread.each(&:join)
      choose_top_gem if top_count.positive?
    end

    def sort_gems(score)
      score.sort_by { |_key, value| value }.last(top_count)
    end

    def choose_top_gem
      total_hash = {}
      sort_gems(group_score(gem_hash)).each { |elem| total_hash[elem[0]] = gem_hash[elem[0]] }
      @gem_hash = total_hash
    end
  end
end
