module  Functions
  # :reek:FeatureEnvy:
  # :reek:TooManyMethods:
  # :reek:TooManyStatements:
  # :reek:UtilityFunction:
  # :reek:ControlParameter:
  class GemManager
    attr_reader :gem_hash
    HIGHEST_COEFFICENT = 3
    MEDIUM_COEFFICENT = 2
    LOW_COEFFICENT = 1

    def initialize
      @gem_hash = {}
    end

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

    def find_repo_html_url(name)
      gem_url = gem_uri(name, 'source_code_uri')
      gem_url = gem_uri(name, 'homepage_uri') if find_uri?(gem_url)
      gem_url = gem_uri(name, 'bug_tracker_uri') if find_uri?(gem_url)
      gem_url
    end

    def response_body_hash(url)
      Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') do |http|
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
        return JSON.parse(response.body, symbolize_names: true)
      end
    end

    def open_file(url)
      raise StandardError, 'Not found url' if url == 'nil'
      Nokogiri::HTML(Kernel.open(url))
    end

    def css_fork_star_watch(doc)
      doc.css('.social-count')
    end

    def css_issues(doc)
      doc.css('.Counter')[0]
    end

    def css_contributers(doc)
      doc.css('.num').css('.text-emphasized')[3]
    end

    def find_fields(url)
      result = []
      doc = open_file(url)
      css_fork_star_watch(doc).each { |elements| result.push(elements.content.gsub(/[^0-9]/, '')) }
      result.push(css_issues(doc).content.gsub(/[^0-9]/, ''))
      result.push(css_contributers(doc).text.gsub(/[^0-9]/, ''))
    end

    def find_used_by(url)
      url += '/network/dependents'
      doc = open_file(url)
      doc.css('.btn-link').css('.selected').text.gsub(/[^0-9]/, '')
    end

    def print_table
      rows = []
      @gem_hash.each { |_key, value| rows << value.strings }
      table = Terminal::Table.new do |tab|
        tab.rows = rows
        tab.style = { border_top: false, border_bottom: false }
      end
      puts table
    end

    def collect_gem_data(gem)
      gem_object = Models::GemModel.new(gem)
      gem_object.url = find_repo_html_url(gem)
      gem_object.install_fields(find_fields(gem_object.url))
      gem_object.count_used_by = find_used_by(gem_object.url)
      gem_object
    end

    def parse_gem_info(file_name: 'gems.yaml', name_gem: nil)
      parsed_yaml_file = extract_gems_from_yaml(file_name)
      threads = []
      parsed_yaml_file.each do |gem|
        next unless gem =~ /#{name_gem}/
        threads << Thread.new { @gem_hash[gem] = collect_gem_data(gem) }
      end
      threads.each(&:join)
    end

    def calculate_score(gem_hash)
      HIGHEST_COEFFICENT * gem_hash[:count_used_by] + MEDIUM_COEFFICENT * gem_hash[:count_watched] *
      gem_hash[:count_stars]*  gem_hash[:count_forks] + LOW_COEFFICENT * gem_hash[:count_contributors] *
      gem_hash[:count_issues]
    end

    def choose_top_gem(top_count)
      score = {}
      hash = {}
      total_hash = {}
      gem_hash.each do |key, value|
        hash = value.fields
        score[key] = calculate_score(hash.slice(:count_used_by, :count_watched, :count_stars,
                                                        :count_forks, :count_contributors, :count_issues))
      end
      score = score.sort_by { |_key, value| value }.last(top_count.to_i)
      score.each { |elem| total_hash[elem[0]] = @gem_hash[elem[0]] }
      @gem_hash = total_hash
    end
  end
end
