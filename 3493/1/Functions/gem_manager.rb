module  Functions
  # :reek:FeatureEnvy:
  # :reek:TooManyMethods:
  # :reek:TooManyStatements:
  # :reek:UtilityFunction:
  # :reek:ControlParameter:
  class GemManager
    attr_reader :gem_hash

    def initialize
      @gem_hash = {}
    end

    def parse_yml_file(file_name)
      file = YAML.load_file(file_name)
      file['gems']
    end

    def gem_uri(name, string)
      Gems.info(name).values_at(string).to_s.delete('", \, [, ]').chomp('/issues')
    end

    def condition_for_search?(gem_url)
      (gem_url == 'nil') || !(gem_url.include? 'https://github.com/') && !(gem_url.include? 'http://github.com/')
    end

    def find_repo_html_url(name)
      gem_url = gem_uri(name, 'source_code_uri')
      gem_url = gem_uri(name, 'homepage_uri') if condition_for_search?(gem_url)
      gem_url = gem_uri(name, 'bug_tracker_uri') if condition_for_search?(gem_url)
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

    def show_table
      rows = []
      @gem_hash.each { |_key, value| rows << value.strings }
      table = Terminal::Table.new do |table|
        table.rows = rows
        table.style = { border_top: false, border_bottom: false }
      end
      puts table
    end

    def collect_gem_object(gem)
      gem_object = Models::GemModel.new(gem)
      gem_object.url = find_repo_html_url(gem)
      gem_object.install_fields(find_fields(gem_object.url))
      gem_object.count_used_by = find_used_by(gem_object.url)
      gem_object
    end

    def parse_gem(file_name: 'gems.yaml', name_gems: nil)
      parsed_yml_file = parse_yml_file(file_name)
      threads = []
      parsed_yml_file.each do |gem|
        next unless gem =~ /#{name_gems}/
        threads << Thread.new { @gem_hash[gem] = collect_gem_object(gem) }
      end
      threads.each(&:join)
    end

    def calculate_score(args)
      3 * args[0] + 2 * args[2] * args[3] * args[5] + 1 * args[1] * args[4]
    end

    def choose_top_gem(top_count)
      score = {}
      hash = {}
      gem_hash.each do |_key, value|
        array = value.fields
        score[array[0]] = calculate_score(array[1..7])
      end
      score = score.sort_by { |_key, value| value }.last(top_count.to_i)
      score.each { |elem| hash[elem[0]] = @gem_hash[elem[0]] }
      @gem_hash = hash
    end
  end
end
