module Models
  class GemInfo
    attr_reader :gem_hash

    def initialize(name, url)
      @gem_hash = {
        name: name,
        url: url,
        count_watched: 0,
        count_stars: 0,
        count_forks: 0,
        count_issues: 0,
        count_contributors: 0
      }
    end

    def save_count_used_by(count_used_by)
      @gem_hash[:count_used_by] = count_used_by.to_i
    end

    def install_fields(args)
      @gem_hash[:count_watched] = args[:watch].to_i
      @gem_hash[:count_stars] = args[:star].to_i
      @gem_hash[:count_forks] = args[:fork].to_i
      @gem_hash[:count_issues] = args[:issues].to_i
      @gem_hash[:count_contributors] = args[:contributers].to_i
    end
  end
end
